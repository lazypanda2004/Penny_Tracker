import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pt/model/acc_model.dart';

class NewAccount extends StatefulWidget {
  const NewAccount({super.key, required this.onaddaccount});

  final void Function(account account) onaddaccount;

  @override
  State<NewAccount> createState() {
    return _NewAccountState();
  }
}

class _NewAccountState extends State<NewAccount> {
  final _providercontroller = TextEditingController();
  final _bankcontroller = TextEditingController();
  DateTime? _selectedDate;
  final _numbercontroller = TextEditingController();

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: const Text('Invalid input'),
                content: const Text(
                    'Please make sure a valid bank name, account number, date and provider name was entered.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('Okay'),
                  ),
                ],
              ));
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid bank name, account number, date and provider name was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  void _submitaccountdata() {
    final numberentered = double.tryParse(_numbercontroller
        .text); // tryParse('Hello') => null, tryParse('1.12') => 1.12
    final numberinvalid = numberentered == null || numberentered <= 0;
    if (_providercontroller.text.trim().isEmpty ||
        numberinvalid ||
        _selectedDate == null ||
        _bankcontroller.text.trim().isEmpty) {
      _showDialog();
      return;
    }

    widget.onaddaccount(
      account(
        provider: _providercontroller.text,
        number: numberentered.toString(),
        expirydate: _selectedDate!,
        bank: _bankcontroller.text,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _providercontroller.dispose();
    _bankcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _bankcontroller,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text('Bank name'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: TextField(
                          controller: _providercontroller,
                          decoration: const InputDecoration(
                            label: Text('Provider name'),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _bankcontroller,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text('Bank name'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: TextField(
                          controller: _providercontroller,
                          decoration: const InputDecoration(
                            label: Text('Provider name'),
                          ),
                        ),
                      ),
                    ],
                  ),
                if (width >= 600)
                  Row(children: [
                    Expanded(
                      child: TextField(
                        controller: _numbercontroller,
                        maxLength: 50,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text('Last 4 numbers of account number'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'No date selected'
                                : formatter.format(_selectedDate!),
                          ),
                          IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(
                              Icons.calendar_month,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ])
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _numbercontroller,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            label: Text('Last 4 digits'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No date selected'
                                  : formatter.format(_selectedDate!),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(
                                Icons.calendar_month,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                if (width >= 600)
                  Row(children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: _submitaccountdata,
                      child: const Text('Save Account'),
                    ),
                  ])
                else
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _submitaccountdata,
                        child: const Text('Save Account'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
