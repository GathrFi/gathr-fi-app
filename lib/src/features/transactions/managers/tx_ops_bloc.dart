import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repositories/transactions/tx_repository.dart';
import '../../../shared/utils/result.dart';

part 'tx_ops_event.dart';
part 'tx_ops_state.dart';
part 'tx_ops_bloc.freezed.dart';

@injectable
class TxOpsBloc extends Bloc<TxOpsEvent, TxOpsState> {
  final TxRepository repository;
  TxOpsBloc(this.repository) : super(const _Initial()) {
    on<_Send>((event, emit) async {
      emit(const _Loading());
      final result = await repository.send(
        recipient: event.recipient,
        amount: event.amount,
      );

      switch (result) {
        case Ok<String>():
          emit(_Success(txHash: result.value));
        case Error<String>():
          emit(_Error(e: result.error));
      }
    });
  }
}
