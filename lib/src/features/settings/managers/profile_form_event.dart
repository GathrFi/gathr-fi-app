part of 'profile_form_bloc.dart';

@freezed
abstract class ProfileFormEvent with _$ProfileFormEvent {
  const factory ProfileFormEvent.update(UserProfile userProfile) = _Update;
  const factory ProfileFormEvent.checkUsername() = _CheckUsername;
}
