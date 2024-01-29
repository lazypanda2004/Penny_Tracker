import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pt/data/get_income.dart';
import 'package:pt/data/get_user_name.dart';
import 'package:pt/data/image_profile.dart';
import 'package:pt/widgets/Debittotal.dart';
import 'package:pt/widgets/credittoatal.dart';
import 'package:pt/widgets/expensetotal.dart';
import 'package:pt/widgets/incometotal.dart';
import 'package:pt/widgets/creditcard.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});
  @override
  State<HomeTab> createState() {
    return _HomeTabState();
  }
}

class _HomeTabState extends State<HomeTab> {
  User user = FirebaseAuth.instance.currentUser!;
  String id = FirebaseAuth.instance.currentUser!.uid;

  String userimageurl = '';
  String username = '';
  String email = '';
  String income = '';
  String expense = '';
  String credit = '';
  String debit = '';

  void getdata() async {
    final DocumentSnapshot userdoc =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    setState(() {
      username = userdoc.get('username');
      email = userdoc.get('email');
      userimageurl = userdoc.get('image_url');
      income = userdoc.get('Income');
      expense = userdoc.get('Expense');
      credit = userdoc.get('Credit');
      debit = userdoc.get('Debit');
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    String id = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(25, 20, 15, 5),
                child: profimage(
                  id: id,
                  radius: 35,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 45, 30, 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Welcome back ',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                        ),
                        getusername(
                          documentid: id,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      'Your transactions are below',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
              child:
                  creditcard(company: 'VISA', balance: 2000, number: '0610')),
          Expanded(
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 1,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 10,
              ),
              children: [
                incometotal(title: 'Income'),
                expensetotal(title: 'Expense'),
                credittotal(title: 'Credit'),
                debittotal(title: 'Debit'),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
