part of 'profile_form_bloc.dart';

@freezed
abstract class ProfileFormState with _$ProfileFormState {
  const factory ProfileFormState(UserProfile userProfile) = _ProfileFormState;
}
