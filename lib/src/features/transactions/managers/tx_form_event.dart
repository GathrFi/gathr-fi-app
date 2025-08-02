part of 'tx_form_bloc.dart';

@freezed
abstract class TxFormEvent with _$TxFormEvent {
  const factory TxFormEvent.changeRecipient(String value) = _ChangeRecipient;
  const factory TxFormEvent.changeAmount(double value) = _ChangeAmount;
}
