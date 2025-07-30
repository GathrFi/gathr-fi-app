import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet/wallet.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
abstract class UserProfile with _$UserProfile {
  const UserProfile._();
  const factory UserProfile({
    String? email,
    String? username,
    String? address,
    @JsonKey(includeFromJson: false, includeToJson: false)
    EtherAmount? walletBalance,
    @JsonKey(includeFromJson: false, includeToJson: false) EtherAmount? balance,
    @JsonKey(includeFromJson: false, includeToJson: false)
    EtherAmount? yieldPercentage,
    @JsonKey(includeFromJson: false, includeToJson: false)
    EtherAmount? yieldAmount,
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
