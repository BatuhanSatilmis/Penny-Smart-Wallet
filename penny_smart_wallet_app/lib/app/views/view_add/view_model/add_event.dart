import 'package:equatable/equatable.dart';

abstract class AddEvent extends Equatable {
  const AddEvent();

  @override
  List<Object> get props => [];
}

class SaveEvent extends AddEvent {
  final String selectedIncomeType;
  final String selectedExpenseType;
  final String amount;
  final DateTime date;
  final String explanation;

  SaveEvent({
    required this.selectedIncomeType,
    required this.selectedExpenseType,
    required this.amount,
    required this.date,
    required this.explanation,
  });

  @override
  List<Object> get props =>
      [selectedIncomeType, selectedExpenseType, amount, date, explanation];
}
