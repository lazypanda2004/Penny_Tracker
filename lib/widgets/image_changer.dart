import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class userchangepicker extends StatefulWidget {
  userchangepicker({
    super.key,
    required this.onPickImage,
  });
  final void Function(File pickedimage) onPickImage;

  @override
  State<userchangepicker> createState() {
    return _userimagepickerstate();
  }
}

class _userimagepickerstate extends State<userchangepicker> {
  File? _pickedImageFile;

  User user = FirebaseAuth.instance.currentUser!;
  String id = FirebaseAuth.instance.currentUser!.uid;
  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage == null) {
      return;
    }
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('users').doc(id).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.1),
                  child: _pickedImageFile == null
                      ? Icon(Icons.camera_alt_outlined)
                      : null,
                  foregroundImage: _pickedImageFile != null
                      ? FileImage(_pickedImageFile!)
                      : null,
                ),
                TextButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.image),
                  label: Text(
                    'Change Image',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                )
              ],
            );
          } else {
            String url = snapshot.data!.get('image_url');

            return Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.1),
                  foregroundImage: _pickedImageFile != null
                      ? FileImage(_pickedImageFile!)
                      : null,
                  child: _pickedImageFile == null ? Image.network(url) : null,
                ),
                TextButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.image),
                  label: Text(
                    'Change Image',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                )
              ],
            );
          }
        });
  }
}
