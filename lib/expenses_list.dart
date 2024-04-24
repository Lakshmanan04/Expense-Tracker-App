import 'package:flutter/material.dart';

import 'package:expense_tracker/data_models/expense_model.dart';
import 'package:expense_tracker/expense_card.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({required this.expensesList,required this.onDelete,super.key});

  final List<Expense> expensesList;
  final void Function(Expense expense) onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: (context, index) => Dismissible(
          key: ValueKey(expensesList[index]),
          onDismissed: (direction) => onDelete(expensesList[index]),
          child: ExpenseCard(
            expense: expensesList[index],
          )),
    );
  }
}
