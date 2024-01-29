import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Credit extends StatelessWidget {
  final String documentid;

  final Color color;
  Credit({super.key, required this.documentid, required this.color});
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Text(
            '₹ ${data['Credit']}',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: color,
                ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        return Text('loading');
      },
    );
  }
}
