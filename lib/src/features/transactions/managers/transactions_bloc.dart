import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repositories/transactions/transactions_repository.dart';
import '../../../shared/utils/result.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';
part 'transactions_bloc.freezed.dart';

@injectable
class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final TransactionsRepository repository;
  TransactionsBloc(this.repository) : super(const _Initial()) {
    on<_Deposit>((event, emit) async {
      emit(const _Loading());
      final result = await repository.deposit(event.amount);

      switch (result) {
        case Ok<String>():
          emit(_Success(result.value));
        case Error<String>():
          emit(_Error(e: result.error));
      }
    });
  }
}
