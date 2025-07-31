part of 'profile_search_bloc.dart';

@freezed
abstract class ProfileSearchEvent with _$ProfileSearchEvent {
  const factory ProfileSearchEvent.search(String query) = _Search;
  const factory ProfileSearchEvent.select(int index) = _Select;
  const factory ProfileSearchEvent.clear() = _Clear;
}
