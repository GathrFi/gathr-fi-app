part of 'profile_bloc.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.load() = _Load;
  const factory ProfileEvent.update(UserProfile userProfile) = _Update;
}
