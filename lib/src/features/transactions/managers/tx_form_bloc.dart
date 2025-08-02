import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'tx_form_event.dart';
part 'tx_form_state.dart';
part 'tx_form_bloc.freezed.dart';

@injectable
class TxFormBloc extends Bloc<TxFormEvent, TxFormState> {
  TxFormBloc() : super(const _TxFormState()) {
    on<_ChangeRecipient>((event, emit) {
      emit(state.copyWith(recipient: event.value));
    });

    on<_ChangeAmount>((event, emit) {
      emit(state.copyWith(amount: event.value));
    });
  }
}
