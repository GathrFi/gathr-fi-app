import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';
import 'package:web3dart/web3dart.dart';

import '../../../shared/utils/callbacks.dart';
import '../../../shared/utils/result.dart';
import '../../models/user/user_profile.dart';
import '../../services/api/graphql_service.dart';
import '../../services/web3/web3_service.dart';

part 'user_profile_repository_impl.dart';

abstract class UserProfileRepository {
  Future<Result<UserProfile>> get();
  Future<Result<List<UserProfile>>> search(String username);
  Future<Result<bool>> checkUsername(String username);
  Future<Result<bool>> update(UserProfile userProfile);
}
