import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Income extends StatefulWidget {
  final String documentid;

  final Color color;
  Income({super.key, required this.documentid, required this.color});

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  User user = FirebaseAuth.instance.currentUser!;
  String id = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return StreamBuilder(
      stream: users.doc(widget.documentid).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text(
            'No Data',
            style: TextStyle(
              color: widget.color,
            ),
          );
        } else {
          String income = snapshot.data!.get('Income');
          return Text(
            '₹$income',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: widget.color,
                ),
          );
        }
      },
    );
  }
}



/* 
     return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Text(
            '₹ ${data['Income']}',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: color,
                  fontSize: 22,
                ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        return Text('loading');
      },
    );
*/