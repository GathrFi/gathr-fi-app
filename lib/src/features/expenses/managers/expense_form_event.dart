part of 'expense_form_bloc.dart';

@freezed
abstract class ExpenseFormEvent with _$ExpenseFormEvent {
  const factory ExpenseFormEvent.started() = _Started;
}
