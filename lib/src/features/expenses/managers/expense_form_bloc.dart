import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'expense_form_event.dart';
part 'expense_form_state.dart';
part 'expense_form_bloc.freezed.dart';

@injectable
class ExpenseFormBloc extends Bloc<ExpenseFormEvent, ExpenseFormState> {
  ExpenseFormBloc() : super(const _ExpenseFormState()) {
    on<ExpenseFormEvent>((event, emit) {});
  }
}
