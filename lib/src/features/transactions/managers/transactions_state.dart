part of 'transactions_bloc.dart';

@freezed
class TransactionsState with _$TransactionsState {
  const factory TransactionsState.initial() = _Initial;
  const factory TransactionsState.loading() = _Loading;
  const factory TransactionsState.success(String txHash) = _Success;
  const factory TransactionsState.error({Exception? e}) = _Error;
}
