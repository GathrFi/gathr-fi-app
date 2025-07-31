import 'package:freezed_annotation/freezed_annotation.dart';

import '../user/user_profile.dart';

part 'group.freezed.dart';
part 'group.g.dart';

@freezed
abstract class Group with _$Group {
  const Group._();
  const factory Group({
    @JsonKey(includeToJson: false) int? id,
    String? name,
    @JsonKey(includeToJson: false) String? admin,
    List<UserProfile>? members,
  }) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  bool get isComplete => name != null && members != null;
}
