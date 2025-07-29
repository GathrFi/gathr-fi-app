part of 'profile_form_bloc.dart';

@freezed
abstract class ProfileFormState with _$ProfileFormState {
  const ProfileFormState._();
  const factory ProfileFormState({
    @Default(UserProfile()) UserProfile userProfile,
    @Default(false) bool isUsernameAvailable,
    @Default(false) bool isLoading,
  }) = _ProfileFormState;
}
