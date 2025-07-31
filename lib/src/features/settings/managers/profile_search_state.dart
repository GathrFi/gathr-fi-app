part of 'profile_search_bloc.dart';

@freezed
class ProfileSearchState with _$ProfileSearchState {
  const factory ProfileSearchState.initial() = _Initial;
  const factory ProfileSearchState.loading() = _Loading;
  const factory ProfileSearchState.loaded({
    @Default([]) List<UserProfile> profiles,
    UserProfile? selectedProfile,
  }) = _Loaded;
  const factory ProfileSearchState.error({Exception? e}) = _Error;
}
