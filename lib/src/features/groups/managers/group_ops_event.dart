part of 'group_ops_bloc.dart';

@freezed
abstract class GroupOpsEvent with _$GroupOpsEvent {
  const factory GroupOpsEvent.add(Group group) = _Add;
}
