part of 'group_ops_bloc.dart';

@freezed
class GroupOpsState with _$GroupOpsState {
  const factory GroupOpsState.initial() = _Initial;
  const factory GroupOpsState.loading() = _Loading;
  const factory GroupOpsState.success(String txHash) = _Success;
  const factory GroupOpsState.error({Exception? e}) = _Error;
}
