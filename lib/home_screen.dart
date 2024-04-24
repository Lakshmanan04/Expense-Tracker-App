import 'package:expense_tracker/chart.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/data_models/expense_model.dart';
import 'package:expense_tracker/expenses_list.dart';
import 'package:expense_tracker/new_expense_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  List<Expense> registeredExpenses = [
    Expense(
      title: 'Lunch',
      amount: 15.78,
      category: Category.food,
      date: DateTime.now(),
    ),
    Expense(
      title: 'Book',
      amount: 10,
      category: Category.work,
      date: DateTime.now(),
    ),
  ];

  void addNewExpenseScreen() {
    showModalBottomSheet(
      context: context,
      builder: (context) => NewExpenseScreen(onSubmit: addNewExpense),
      isScrollControlled: true,
      useSafeArea: true,
    );
  }

  void removeExpense(Expense expense) {
    final index = registeredExpenses.indexOf(expense);
    setState(() {
      registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense Deleted'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(
              () {
                registeredExpenses.insert(index, expense);
              },
            );
          },
        ),
      ),
    );
  }

  void addNewExpense(Expense expense) {
    setState(() {
      registeredExpenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: addNewExpenseScreen,
          )
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: registeredExpenses),
                registeredExpenses.isEmpty
                    ? const Center(child: Text('No expenses added...'))
                    : Expanded(
                        child: ExpenseList(
                            expensesList: registeredExpenses,
                            onDelete: removeExpense)),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: registeredExpenses)),
                registeredExpenses.isEmpty
                    ? const Center(child: Text('No expenses added...'))
                    : Expanded(
                        child: ExpenseList(
                            expensesList: registeredExpenses,
                            onDelete: removeExpense)),
              ],
            ),
    );
  }
}
