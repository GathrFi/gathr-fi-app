part of 'tx_form_bloc.dart';

@freezed
abstract class TxFormState with _$TxFormState {
  const factory TxFormState({
    @Default('') String recipient,
    @Default(0) double amount,
  }) = _TxFormState;
}
