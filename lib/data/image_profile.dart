import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class profimage extends StatefulWidget {
  profimage({super.key, required this.id, required this.radius});
  String id;
  double radius;
  @override
  State<profimage> createState() {
    return _profimagestate();
  }
}

class _profimagestate extends State<profimage> {
  User user = FirebaseAuth.instance.currentUser!;
  String id = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.id)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text('No image is uploaded'),
          );
        } else {
          String url = snapshot.data!.get('image_url');
          return CircleAvatar(
            foregroundImage: Image.network(url).image,
            backgroundColor: Theme.of(context).colorScheme.onBackground,
            radius: widget.radius,
          );
        }
      },
    );
  }
}
