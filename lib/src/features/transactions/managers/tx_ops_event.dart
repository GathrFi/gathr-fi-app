part of 'tx_ops_bloc.dart';

@freezed
abstract class TxOpsEvent with _$TxOpsEvent {
  const factory TxOpsEvent.send({
    required String recipient,
    required double amount,
  }) = _Send;
}
