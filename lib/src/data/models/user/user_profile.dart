import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
abstract class UserProfile with _$UserProfile {
  const UserProfile._();
  const factory UserProfile({
    String? email,
    String? username,
    String? address,
    String? image,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  bool get isComplete =>
      email != null &&
      email!.isNotEmpty &&
      username != null &&
      username!.isNotEmpty &&
      address != null &&
      address!.isNotEmpty;
}
