import 'package:expense_tracker/widgets/expenses_list/expenses_list_page.dart';
import 'package:expense_tracker/models/single_expense.dart';
import 'package:expense_tracker/widgets/new_expenses.dart';
import 'package:flutter/material.dart';

/// !context --- it is a meta data collection that belongs to specific widget
/// ?    ---- contains widget position information

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<SingleExpense> _registeredExpenses = [
    SingleExpense(
        title: 'flutter course',
        amount: 19.9,
        date: DateTime.now(),
        category: Category.work),
    SingleExpense(
        title: 'cinema',
        amount: 15.69,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _openExpenseAdder() {
    showModalBottomSheet(
        isScrollControlled: true, //! keyboard do not with any inputs
        context: context,
        builder: (ctx) {
          return NewExpense(
            onAddExpense: addExpense,
          );
        });
  }

  void addExpense(SingleExpense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void removeExpense(SingleExpense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });
    /**
     *  undo button for expense item
     */
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: () {
              _openExpenseAdder();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text("the chart"),
          Expanded(
            child: ExpensesListPage(
              listOfExpenses: _registeredExpenses,
              removeExpense: removeExpense,
            ),
          ),
        ],
      ),
    );
  }
}

class ExpensesBucket {
  const ExpensesBucket({required this.category, required this.expenses});

  ExpensesBucket.forCategory(List<SingleExpense> allExpenses, this.category)
      : expenses = allExpenses
            .where((element) => element.category == category)
            .toList();

  final Category category;
  final List<SingleExpense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
