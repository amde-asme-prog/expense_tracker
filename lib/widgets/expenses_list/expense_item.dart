import 'package:expense_tracker/models/single_expense.dart';
import 'package:flutter/material.dart';

class ExpenseItemPage extends StatelessWidget {
  const ExpenseItemPage(this.expenseItem, {super.key});

  final SingleExpense expenseItem;

  @override
  Widget build(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expenseItem.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  '\$${expenseItem.amount.toStringAsFixed(2)}',
                ),
                // const SizedBox(
                //   width: 20,
                // ),
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      CategoryIcons[expenseItem.category],
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(expenseItem.formattedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
