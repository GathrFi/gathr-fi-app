part of 'transactions_bloc.dart';

@freezed
abstract class TransactionsEvent with _$TransactionsEvent {
  const factory TransactionsEvent.deposit(double amount) = _Deposit;
}
