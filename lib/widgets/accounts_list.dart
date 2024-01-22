import 'package:flutter/material.dart';

import 'package:pt/widgets/acclistitem.dart';
import 'package:pt/model/acc_model.dart';

class Accountlist extends StatelessWidget {
  const Accountlist({
    super.key,
    required this.accounts_,
    required this.onremoveaccount,
  });

  final List<account> accounts_;
  final void Function(account account) onremoveaccount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: accounts_.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(accounts_[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
        ),
        onDismissed: (direction) {
          onremoveaccount(accounts_[index]);
        },
        child: Accountitem(
          accounts_[index],
        ),
      ),
    );
  }
}
