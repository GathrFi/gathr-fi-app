import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wallet/wallet.dart';
import 'package:web3dart/web3dart.dart';

import '../../../shared/utils/callbacks.dart';
import '../../../shared/utils/result.dart';
import '../../models/group/group.dart';
import '../../models/user/user_profile.dart';
import '../../services/api/graphql_service.dart';
import '../../services/web3/web3_service.dart';

part 'groups_repository_impl.dart';

abstract class GroupsRepository {
  Future<Result<String>> addGroup(Group group);
  Future<Result<List<GroupWithProfiles>>> getList();
}
