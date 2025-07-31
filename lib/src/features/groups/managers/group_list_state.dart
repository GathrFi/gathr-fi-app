part of 'group_list_bloc.dart';

@freezed
class GroupListState with _$GroupListState {
  const factory GroupListState.initial() = _Initial;
  const factory GroupListState.loading() = _Loading;
  const factory GroupListState.loaded(List<GroupWithProfiles> items) = _Loaded;
  const factory GroupListState.error({Exception? e}) = _Error;
}
