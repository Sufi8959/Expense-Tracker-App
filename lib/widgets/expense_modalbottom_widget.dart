import 'package:expense_tracker/constants/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_model.dart';

class ExpenseModalWidget extends StatefulWidget {
  const ExpenseModalWidget({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<ExpenseModalWidget> createState() {
    return _ExpenseModalWidget();
  }
}

class _ExpenseModalWidget extends State<ExpenseModalWidget> {
  final _enteredTextController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;
  void _showDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsinvalid = enteredAmount == null || enteredAmount <= 0;
    if (_enteredTextController.text.trim().isEmpty ||
        amountIsinvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Center(
            child: Text(
              'Please enter something',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
            ),
          ),
        ),
      );
      // print(enteredAmount);
      // print(amountIsinvalid);
      // print(_selectedCategory);
      // print(_selectedDate);
      // print(_enteredTextController);
      return;
    }

    widget.onAddExpense(
      Expense(
        amount: enteredAmount,
        date: _selectedDate!,
        title: _enteredTextController.text,
        category: _selectedCategory,
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _enteredTextController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextFormField(
            controller: _enteredTextController,
            //  maxLength: 50,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              label: const Text('Title'),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    prefixText: '\$ ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    label: const Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _selectedDate == null
                          ? "No Date Selected"
                          : formnatter.format(_selectedDate!),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: lightColorScheme.secondary),
                    ),
                    IconButton(
                        onPressed: _showDatePicker,
                        icon: const Icon(Icons.calendar_month_rounded))
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                  borderRadius: BorderRadius.circular(15),
                  dropdownColor: lightColorScheme.primaryContainer,
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text('Save Expense'),
              )
            ],
          )
        ],
      ),
    );
  }
}
