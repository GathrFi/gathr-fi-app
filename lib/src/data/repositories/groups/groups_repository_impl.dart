part of 'groups_repository.dart';

@LazySingleton(as: GroupsRepository)
class GroupsRepositoryImpl implements GroupsRepository {
  GroupsRepositoryImpl(
    this.supabaseClient,
    this.web3client,
    this.graphQLService,
  );

  final SupabaseClient supabaseClient;
  final Web3Client web3client;
  final GraphQLService graphQLService;

  FunctionsClient get _functions => supabaseClient.functions;

  @override
  Future<Result<String>> addGroup(Group group) {
    return Callbacks.executeBlockchain<String>(
      operation: (credentials, address) async {
        final gathrfiContract = await Web3Service.gathrfiContract;
        final txAddGroup = await web3client.sendTransaction(
          credentials,
          chainId: int.tryParse(Web3Service.chainConfig.chainId),
          Transaction.callContract(
            contract: gathrfiContract,
            function: gathrfiContract.function('createGroup'),
            parameters: [
              group.name,
              group.members?.map((member) {
                return EthereumAddress.fromHex(member);
              }).toList(),
            ],
          ),
        );

        await Web3Service.waitForTxReceipt(txAddGroup);
        return txAddGroup;
      },
    );
  }

  @override
  Future<Result<List<GroupWithProfiles>>> getList({String? member}) {
    return Callbacks.executeBlockchain<List<GroupWithProfiles>>(
      operation: (credentials, address) async {
        final groupsQuery = r'''
          query GetGroups($members_has: String = "") {
            groupss(where: {members_has: $members_has}) {
              items {
                admin
                id
                members
                name
              }
            }
          }
        ''';

        final groupsResult = await graphQLService.query(groupsQuery, {
          'members_has': member ?? address.eip55With0x,
        });

        final groups = (groupsResult.data?['groupss']['items'] as List)
            .map((group) => Group.fromJson(group))
            .toList();

        final memberAddresses = <String>{};
        for (Group group in groups) {
          for (String member in (group.members ?? [])) {
            memberAddresses.add(member);
          }
        }

        final memberProfiles = <String, UserProfile>{};
        for (String memberAddress in memberAddresses) {
          final address = EthereumAddress.fromHex(memberAddress).eip55With0x;
          final profileResult = await _functions.invoke(
            'get-user-profile',
            body: {'address': address},
          );

          if (profileResult.data != null) {
            final profile = UserProfile.fromJson(profileResult.data);
            memberProfiles[address] = profile;
          }
        }

        return groups.map((group) {
          final profiles = <String, UserProfile>{};

          for (String member in (group.members ?? [])) {
            final memberAddress = EthereumAddress.fromHex(member).eip55With0x;
            if (memberProfiles.containsKey(memberAddress)) {
              profiles[memberAddress] = memberProfiles[memberAddress]!;
            }
          }

          return GroupWithProfiles(group: group, memberProfiles: profiles);
        }).toList();
      },
    );
  }
}
