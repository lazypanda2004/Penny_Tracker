import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pt/model/acc_model.dart';
import 'package:pt/screens/accounts.dart';

class accountsnotifier extends StateNotifier<List<account>> {
  accountsnotifier()
      : super([
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
        ]);
}

final accountsprovider =
    StateNotifierProvider<accountsnotifier, List<account>>((ref) {
  return accountsnotifier();
});
