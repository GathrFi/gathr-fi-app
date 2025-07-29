import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../shared/utils/callbacks.dart';
import '../../../shared/utils/result.dart';
import '../../models/user/user_profile.dart';

part 'user_profile_repository_impl.dart';

abstract class UserProfileRepository {
  Future<Result<bool>> checkUsername(String username);
  Future<Result<bool>> update(UserProfile userProfile);
  Future<Result<UserProfile>> get(String address);
  Future<Result<List<UserProfile>>> search(String username);
}
