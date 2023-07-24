import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import '../../models/single_expense.dart';

class ExpensesListPage extends StatelessWidget {
  const ExpensesListPage(
      {super.key, required this.listOfExpenses, required this.removeExpense});

  final List<SingleExpense> listOfExpenses;
  final void Function(SingleExpense expense) removeExpense;

  @override
  Widget build(context) {
    //!ListView.builder is special widget for building lists when we are about to use them
    //!----it builds the list when they are visible or when they are about to become visible
    return ListView.builder(
      itemCount: listOfExpenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.70),
        ),
        onDismissed: (direction) {
          removeExpense(listOfExpenses[index]);
        },
        key: ValueKey(listOfExpenses[index]),
        child: ExpenseItemPage(
          listOfExpenses[index],
        ),
      ),
    );
  }
}
