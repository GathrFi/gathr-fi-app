import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense.freezed.dart';
part 'expense.g.dart';

@freezed
abstract class Expense with _$Expense {
  const Expense._();
  const factory Expense({
    String? payer,
    double? amount,
    double? amountSettled,
    String? description,
    bool? fullySettled,
  }) = _Expense;

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);

  bool get isComplete =>
      payer != null &&
      payer!.isNotEmpty &&
      amount != null &&
      description != null &&
      description!.isNotEmpty;
}

@freezed
abstract class ExpenseSplit with _$ExpenseSplit {
  const ExpenseSplit._();
  const factory ExpenseSplit({String? member, double? amount}) = _ExpenseSplit;

  factory ExpenseSplit.fromJson(Map<String, dynamic> json) =>
      _$ExpenseSplitFromJson(json);

  bool get isComplete => member != null && amount != null;
}

@freezed
abstract class ExpenseWithSplits with _$ExpenseWithSplits {
  const ExpenseWithSplits._();
  const factory ExpenseWithSplits({
    required Expense expense,
    required Map<String, ExpenseSplit> splits,
  }) = _ExpenseWithSplits;

  factory ExpenseWithSplits.fromJson(Map<String, dynamic> json) =>
      _$ExpenseWithSplitsFromJson(json);

  bool get isComplete => expense.isComplete && splits.isNotEmpty;
}
