part of 'user_profile_repository.dart';

@LazySingleton(as: UserProfileRepository)
class UserProfileRepositoryImpl implements UserProfileRepository {
  UserProfileRepositoryImpl(
    this.supabaseClient,
    this.web3client,
    this.graphQLService,
  );

  final SupabaseClient supabaseClient;
  final Web3Client web3client;
  final GraphQLService graphQLService;

  FunctionsClient get _functions => supabaseClient.functions;

  @override
  Future<Result<UserProfile>> get() {
    return Callbacks.executeBlockchain<UserProfile>(
      operation: (credentials, address) async {
        final userInfo = await Web3AuthFlutter.getUserInfo();
        final userAddress = address.eip55With0x;

        final mockUsdcContract = await Web3Service.mockUsdcContract;
        final mockUsdcResponse = await web3client.call(
          contract: mockUsdcContract,
          function: mockUsdcContract.function('balanceOf'),
          params: [address],
        );

        UserProfile userProfile = UserProfile(
          email: userInfo.email,
          address: userAddress,
          walletBalance: (mockUsdcResponse[0] as BigInt).toTokenAmount(),
          balance: BigInt.from(0).toTokenAmount(),
          yieldPercentage: BigInt.from(0).toTokenAmount(),
          yieldAmount: BigInt.from(0).toTokenAmount(),
        );

        final profileResponse = await _functions.invoke(
          'get-user-profile',
          body: {'address': userAddress},
        );

        if (profileResponse.data != null) {
          final profile = UserProfile.fromJson(profileResponse.data);
          userProfile = userProfile.copyWith(
            username: profile.username,
            image: profile.image,
          );
        }

        final statsQuery = r'''
          query GetUserStats($id: String!) {
            userStats(id: $id) {
              id
              balance
              yieldPercentage
              yieldAmount
            }
          }
        ''';

        final statsQueryParams = {'id': address.eip55With0x};
        final statsResult = await graphQLService.query(
          statsQuery,
          statsQueryParams,
        );

        final stats = statsResult.data?['userStats'] as Map<String, dynamic>?;
        final balance = BigInt.tryParse(stats?['balance'])?.toTokenAmount();
        final yieldPercentage = BigInt.tryParse(
          stats?['yieldPercentage'],
        )?.toTokenAmount(decimals: 2);
        final yiledAmount = BigInt.tryParse(
          stats?['yieldAmount'],
        )?.toTokenAmount();

        userProfile = userProfile.copyWith(
          balance: balance,
          yieldPercentage: yieldPercentage,
          yieldAmount: yiledAmount,
        );

        return userProfile;
      },
    );
  }

  @override
  Future<Result<List<UserProfile>>> search(String username) {
    return Callbacks.executeWithTryCatch<List<UserProfile>>(
      operation: () async {
        final response = await _functions.invoke(
          'search-user-profiles',
          body: {'username': username},
        );

        return (response.data as List)
            .map((item) => UserProfile.fromJson(item))
            .toList();
      },
    );
  }

  @override
  Future<Result<bool>> checkUsername(String username) {
    return Callbacks.executeWithTryCatch<bool>(
      operation: () async {
        final response = await _functions.invoke(
          'check-username',
          body: {'username': username},
        );

        if (response.data == null) {
          throw const AppException('Username already taken');
        }

        return response.data['available'] as bool;
      },
    );
  }

  @override
  Future<Result<bool>> update(UserProfile userProfile) {
    return Callbacks.executeWithTryCatch<bool>(
      operation: () async {
        await _functions.invoke(
          'upsert-user-profile',
          body: userProfile.toJson(),
        );

        return true;
      },
    );
  }
}
