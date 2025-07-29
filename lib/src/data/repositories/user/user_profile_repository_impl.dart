part of 'user_profile_repository.dart';

@LazySingleton(as: UserProfileRepository)
class UserProfileRepositoryImpl implements UserProfileRepository {
  UserProfileRepositoryImpl(this.supabaseClient);
  final SupabaseClient supabaseClient;

  @override
  Future<Result<bool>> update(UserProfile userProfile) {
    return Callbacks.executeWithTryCatch<bool>(
      operation: () async {
        await supabaseClient.functions.invoke(
          'upsert-user-profile',
          body: userProfile.toJson(),
        );

        return true;
      },
    );
  }

  @override
  Future<Result<UserProfile>> get(String address) {
    return Callbacks.executeWithTryCatch<UserProfile>(
      operation: () async {
        final response = await supabaseClient.functions.invoke(
          'get-user-profile',
          body: {'address': address},
        );

        if (response.data == null) {
          throw const AppException('User profile has not been created yet');
        }

        return UserProfile.fromJson(response.data);
      },
    );
  }

  @override
  Future<Result<List<UserProfile>>> search(String username) {
    return Callbacks.executeWithTryCatch<List<UserProfile>>(
      operation: () async {
        final response = await supabaseClient.functions.invoke(
          'search-user-profiles',
          body: {'username': username},
        );

        return (response.data as List)
            .map((item) => UserProfile.fromJson(item))
            .toList();
      },
    );
  }
}
