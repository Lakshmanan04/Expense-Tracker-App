import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final dateFormatter = DateFormat.yMd();

enum Category { leisure, travel, work, food }

final categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.work: Icons.work,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final Category category;
  final DateTime date;

  String get dateFormatted {
    return dateFormatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.expenses,required this.category});

  ExpenseBucket.forCategory(List<Expense> allExpenses,this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount; 
    }

    return sum;
  }
}
