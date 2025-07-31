part of 'group_list_bloc.dart';

@freezed
abstract class GroupListEvent with _$GroupListEvent {
  const factory GroupListEvent.get() = _Get;
}
