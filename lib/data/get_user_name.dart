import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class getusername extends StatelessWidget {
  final String documentid;
    String name = '';
   final Color color;
  getusername({super.key, required this.documentid, required this.color});
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          name = data['username'];
          name = name[0].toUpperCase() + name.substring(1);
          return Text(
            '${name}',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
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
  }
}
