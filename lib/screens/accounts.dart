import 'package:flutter/material.dart';

import 'package:pt/widgets/new_account.dart';
import 'package:pt/widgets/accounts_list.dart';
import 'package:pt/model/acc_model.dart';

class Accounts extends StatefulWidget {
  const Accounts({super.key});

  @override
  State<Accounts> createState() {
    return _AccountsState();
  }
  
}

class _AccountsState extends State<Accounts> {
  final List<account> _registeredAccounts = [
    account(
      provider: 'Visa',
      bank: 'HDFC',
      expirydate: DateTime.now(),
      number: '0610',
    ),
    account(
      provider: 'Visa',
      bank: 'SBI',
      expirydate: DateTime.now(),
      number: '0611',
    ),
  ];

  void _openaddaccountoverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewAccount(onaddaccount: _addaccount),
    );
  }

List<account> get registeredAccounts {
  return _registeredAccounts;
}

  void _addaccount(account account) {
    setState(() {
      _registeredAccounts.add(account);
    });
  }

  void _removeaccount(account account) {
    final accountindex = _registeredAccounts.indexOf(account);
    setState(() {
      _registeredAccounts.remove(account);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Account deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredAccounts.insert(accountindex, account);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No Accounts found. Start adding some!'),
    );

    if (_registeredAccounts.isNotEmpty) {
      mainContent = Accountlist(
        accounts_: _registeredAccounts,
        onremoveaccount: _removeaccount,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
            onPressed: _openaddaccountoverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          mainContent,
        ],
      ),
    );
  }
}
