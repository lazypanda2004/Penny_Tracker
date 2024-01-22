import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pt/data/image_profile.dart';
import 'package:pt/screens/home_tab.dart';
import 'package:pt/widgets/image_select.dart';
import 'package:pt/widgets/updateimage.dart';

class editprof extends StatefulWidget {
  editprof({super.key, required this.id});
  String id;
  @override
  State<editprof> createState() {
    return _editprofstate();
  }
}

class _editprofstate extends State<editprof> {
  final _form = GlobalKey<FormState>();
  File? _selectedImage;

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }
    if (_selectedImage == null) {
      _form.currentState!.save();

      try {} on FirebaseAuthException catch (error) {
        if (error.code == 'email-already-in-use') {
          // ...
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? 'Changes failed.'),
          ),
        );
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Saved Changes')));
      Navigator.pop(context);
    } else {
      _form.currentState!.save();

      try {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${widget.id}.jpg');

        await storageRef.putFile(_selectedImage!);
        final imageUrl = await storageRef.getDownloadURL();
        FirebaseFirestore.instance
            .collection('users')
            .doc(widget.id)
            .update({'image_url': imageUrl});
      } on FirebaseAuthException catch (error) {
        if (error.code == 'email-already-in-use') {
          // ...
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? 'Changes failed.'),
          ),
        );
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Saved Changes')));
      Navigator.pop(context);
    }
  }

  var isobscure = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.chevron_left_outlined),
          ),
          title: Text(
            'Edit profile',
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          userimagepicker(
                            onPickImage: (pickedImage) {
                              _selectedImage = pickedImage;
                            },
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 15, 10, 10),
                            child: Form(
                              key: _form,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(widget.id)
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<DocumentSnapshot>
                                            snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: Text('No image is uploaded'),
                                        );
                                      } else {
                                        String username =
                                            snapshot.data!.get('username');
                                        return TextFormField(
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                          autocorrect: false,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          textCapitalization:
                                              TextCapitalization.none,
                                          decoration: InputDecoration(
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground,
                                                ),
                                            hintText: username,
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return 'Please enter a valid username.';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(widget.id)
                                                .update({'username': value});
                                          },
                                        );
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(widget.id)
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<DocumentSnapshot>
                                            snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: Text('No image is uploaded'),
                                        );
                                      } else {
                                        String __email =
                                            snapshot.data!.get('email');
                                        return TextFormField(
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                          autocorrect: false,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          textCapitalization:
                                              TextCapitalization.none,
                                          decoration: InputDecoration(
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground,
                                                ),
                                            hintText: __email,
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty ||
                                                !value.contains('@')) {
                                              return 'Please enter a valid email.';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(widget.id)
                                                .update({'email': value});
                                          },
                                        );
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          child: SizedBox(
                                            width: 200,
                                            height: 50,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                _submit();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                    .withOpacity(0.7),
                                              ),
                                              child: Text(
                                                'Save changes',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                      color: Colors.white,
                                                      fontFamily: 'Lexend',
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
