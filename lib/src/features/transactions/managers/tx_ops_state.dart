part of 'tx_ops_bloc.dart';

@freezed
class TxOpsState with _$TxOpsState {
  const factory TxOpsState.initial() = _Initial;
  const factory TxOpsState.loading() = _Loading;
  const factory TxOpsState.success({required String txHash}) = _Success;
  const factory TxOpsState.error({Exception? e}) = _Error;
}
