import 'package:flutter/material.dart';

import 'package:pt/model/acc_model.dart';

class Accountitem extends StatelessWidget {
  const Accountitem(this._account, {super.key});

  final account _account;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onBackground,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '****   ' + _account.number.toString(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  _account.bank,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  _account.provider,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Spacer(),
                Text(
                  _account.formattedDate,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
