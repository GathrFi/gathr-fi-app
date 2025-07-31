import 'package:freezed_annotation/freezed_annotation.dart';

import '../user/user_profile.dart';

part 'group.freezed.dart';
part 'group.g.dart';

@freezed
abstract class Group with _$Group {
  const Group._();
  const factory Group({
    @JsonKey(includeToJson: false) String? id,
    @JsonKey(includeToJson: false) String? admin,
    String? name,
    List<String>? members,
  }) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  bool get isComplete => name != null && members != null;
}

@freezed
abstract class GroupWithProfiles with _$GroupWithProfiles {
  const GroupWithProfiles._();
  const factory GroupWithProfiles({
    required Group group,
    required Map<String, UserProfile> memberProfiles,
  }) = _GroupWithProfiles;

  bool get isComplete => group.isComplete && memberProfiles.isNotEmpty;
}
