import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:pt/widgets/expenseitem.dart';
import 'package:pt/model/expense.dart';

class ExpensesList extends StatefulWidget {
  const ExpensesList({
    super.key,
    required this.onRemoveExpense,
  });

  final void Function(Expense expense) onRemoveExpense;

  @override
  State<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  User user = FirebaseAuth.instance.currentUser!;
  String id = FirebaseAuth.instance.currentUser!.uid;

  List expenses = [];
  Future getdata() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('transactions')
        .get()
        .then((value) {
      for (var i in value.docs) {
        expenses.add(i.data());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getdata();

    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        onDismissed: (direction) {
          widget.onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(
          expenses[index],
        ),
      ),
    );
  }
}
