import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum type {
  Expense,
  Income,
  Credit,
  Debit,
}

enum Category {
  groceries,
  rent,
  transportation,
  dining,
  entertainment,
  health,
  investment,
  shopping,
  home,
  education,
  travel,
  subscriptions,
  electronics,
  personal_care,
  emi,
  hobbies,
  miscellaneous,
}

const categoryicons = {
  Category.groceries: Icons.local_grocery_store,
  Category.rent: Icons.home,
  Category.transportation: Icons.flight_takeoff,
  Category.dining: Icons.dining,
  Category.entertainment: Icons.movie,
  Category.health: Icons.favorite,
  Category.investment: Icons.monetization_on,
  Category.shopping: Icons.shopping_bag,
  Category.home: Icons.home,
  Category.education: Icons.school,
  Category.travel: Icons.home,
  Category.subscriptions: Icons.home,
  Category.electronics: Icons.devices,
  Category.personal_care: Icons.spa,
  Category.emi: Icons.payment,
  Category.hobbies: Icons.sports_baseball,
  Category.miscellaneous: Icons.note,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.mode,
    required this.edhi,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final int amount;
  final DateTime date;
  final Category category;
  final String mode;
  final type edhi;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum = sum + expense.amount;
    }

    return sum;
  }
}
