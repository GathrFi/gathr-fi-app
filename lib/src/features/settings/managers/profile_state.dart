part of 'profile_bloc.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.loaded(UserProfile userProfile) = _Loaded;
  const factory ProfileState.error({Exception? e}) = _Error;
}
