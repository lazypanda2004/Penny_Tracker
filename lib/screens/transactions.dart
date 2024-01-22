import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:pt/widgets/new_expense.dart';
import 'package:pt/widgets/expenselist.dart';
import 'package:pt/model/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  User user = FirebaseAuth.instance.currentUser!;
  String id = FirebaseAuth.instance.currentUser!.uid;
  final List<Expense> _registeredExpenses = [];

  Future<String> gettransid(Expense expense) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('transactions')
        .where('id', isEqualTo: expense.id)
        .get();
    return snapshot.docs.first.id;
  }

  Future<int> count() async {
    AggregateQuerySnapshot mydoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('transactions')
        .count()
        .get();
    return mydoc.count;
  }

  void _addExpense(Expense expense) async {
    BuildContext currentcontext = context;
    final CollectionReference result = FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('transactions');
    if (mounted) {
      setState(() {
        FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .collection('transactions')
            .add({
          'mode': expense.mode,
          'amount': expense.amount,
          'category': expense.category,
          'date': expense.formattedDate,
          'id': expense.id,
          'title': expense.title,
        });
      });
    }
    ScaffoldMessenger.of(currentcontext).showSnackBar(
      SnackBar(
        content: const Text('Expense added.'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () async {
            // Your undo logic here
            // Example: await result.delete();
            // Check if the widget is still mounted before calling setState
            Future<String> transid = gettransid(expense);
            if (mounted) {
              setState(() {
                result.doc(transid as String?).delete();
              });
            }
          },
        ),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _removeExpense(Expense expense) async {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    final transid = await gettransid(expense);
    if (mounted) {
      setState(() {
        FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('transactions')
        .doc(transid).delete();
      });
    }
    final x = await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('transactions')
        .doc(transid);

    // Check if the widget is still mounted before calling setState
    if (mounted) {
      setState(() {
        x.delete();
      });
    }
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _addExpense(expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = ExpensesList(
      onRemoveExpense: _removeExpense,
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter PennyTracker'),
          actions: [
            IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: mainContent,
            ),
          ],
        ));
  }
}
