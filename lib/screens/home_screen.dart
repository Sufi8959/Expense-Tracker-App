import 'package:expense_tracker/constants/color_schemes.g.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widgets/charts/chart.dart';
import 'package:expense_tracker/widgets/expense_modalbottom_widget.dart';
import 'package:expense_tracker/widgets/expense_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Expense> _registeredExpenses = [
    Expense(
      amount: 1.99,
      date: DateTime.now(),
      title: 'Flutter development',
      category: Category.work,
    ),
    Expense(
      amount: 2.01,
      date: DateTime.now(),
      title: 'Entertainment',
      category: Category.leisure,
    ),
    Expense(
      amount: 3.54,
      date: DateTime.now(),
      title: 'Fried Chicken',
      category: Category.food,
    ),
  ];

  addModalBottomSheetOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      backgroundColor: lightColorScheme.primaryContainer,
      isScrollControlled: true,
      context: context,
      builder: (context) => ExpenseModalWidget(
        onAddExpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text('No expenses found, Start adding some'),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpenseListWidget(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: addModalBottomSheetOverlay,
              icon: const Icon(Icons.add))
        ],
        title: const Text(
          'Expense Tracker',
        ),
      ),
      body: width <= 330
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: mainContent,
                )
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
