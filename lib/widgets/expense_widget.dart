import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widgets/expenses_card_widget.dart';
import 'package:flutter/material.dart';

class ExpenseListWidget extends StatelessWidget {
  const ExpenseListWidget(
      {super.key, required this.expenses, required this.onRemoveExpense});
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return Dismissible(
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
          },
          key: ValueKey(expenses[index]),
          child: ExpenseItem(expenses[index]),
        );
      },
    );
  }
}
