import 'package:flutter/material.dart';

import 'package:expense_tracker/data_models/expense_model.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({required this.expense, super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title),
            Row(
              children: [
                Text('₹${expense.amount}'),
                const Spacer(),
                Icon(categoryIcons[expense.category]),
                Text(expense.dateFormatted),
              ],
            )
          ],
        ),
      ),
    );
  }
}
