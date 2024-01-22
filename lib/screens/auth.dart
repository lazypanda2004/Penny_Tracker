import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pt/screens/home_tab.dart';
import 'dart:io';
import 'package:pt/widgets/image_select.dart';
import 'package:firebase_storage/firebase_storage.dart';

final _firebase = FirebaseAuth.instance;

class Authscreen extends StatefulWidget {
  const Authscreen({super.key});
  @override
  State<Authscreen> createState() {
    return _Authscreenstate();
  }
}

class _Authscreenstate extends State<Authscreen> {
  final _form = GlobalKey<FormState>();
  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _username = '';
  File? _selectedImage;
  var _isAuthenticating = false;

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid || !_isLogin && _selectedImage == null) {
      return;
    }

    _form.currentState!.save();

    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (_isLogin) {
        final userCredentials = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        HomeTab();
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredentials.user!.uid}.jpg');

        await storageRef.putFile(_selectedImage!);
        final imageUrl = await storageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
          'Income': '0',
          'Expense': '0',
          'Debit': '0',
          'Credit': '0',
          'username': _username,
          'email': _enteredEmail,
          'image_url': imageUrl,
        });
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        // ...
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed.'),
        ),
      );
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Account created plz continue'),
        ),
      );
      ScaffoldMessenger.of(context).clearSnackBars();

      HomeTab();
    }
  }

  @override
  Widget build(BuildContext context) {
    var isobscure = true;

    return _isLogin
        ? Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: SafeArea(
              child: Column(children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(23, 35, 23, 0),
                          child: Row(
                            children: [
                              Image.asset(
                                'images/dollar.png',
                                width: 75,
                                height: 80,
                                fit: BoxFit.fitWidth,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Text(
                                  'PT',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontFamily: 'Lexend',
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.italic,
                                      ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(31, 0, 23, 0),
                          child: Text(
                            'Welcome back',
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(31, 25, 31, 10),
                          child: Form(
                            key: _form,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  autocorrect: false,
                                  keyboardType: TextInputType.emailAddress,
                                  textCapitalization: TextCapitalization.none,
                                  decoration: InputDecoration(
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                    hintText: 'Enter your email',
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
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().isEmpty ||
                                        !value.contains('@')) {
                                      return 'Please enter a valid email address.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _enteredEmail = value!;
                                    value = '';
                                  },
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  autocorrect: false,
                                  obscureText: isobscure,
                                  textCapitalization: TextCapitalization.none,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isobscure = !isobscure;
                                        });
                                      },
                                      icon: Icon(isobscure
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                    ),
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground),
                                    hintText: 'Enter your Password',
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
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().length < 6) {
                                      return 'Password must be at least 6 characters long.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _enteredPassword = value!;
                                    value = '';
                                  },
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                if (_isAuthenticating)
                                  const CircularProgressIndicator(),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          143 -
                                          39,
                                    ),
                                    SizedBox(
                                      width: 120,
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: _submit,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.7),
                                        ),
                                        child: Text(
                                          'Login',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: Colors.white,
                                                fontFamily: 'Lexend',
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                Center(
                                  child: SizedBox(
                                    width: 267,
                                    height: 50,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                            .withOpacity(0.1),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isLogin = !_isLogin;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            'Do not have an account',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                  color: Colors.white,
                                                ),
                                          ),
                                          SizedBox(
                                            width: 18,
                                          ),
                                          Text(
                                            'Create',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 70,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Image.asset(
                          'images/background.jpg',
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          )
        : Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: SafeArea(
              child: Column(children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(31, 0, 23, 0),
                          child: Text(
                            'Get started',
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: userimagepicker(
                            onPickImage: (pickedImage) {
                              _selectedImage = pickedImage;
                            },
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(31, 15, 31, 10),
                          child: Form(
                            key: _form,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  autocorrect: false,
                                  keyboardType: TextInputType.emailAddress,
                                  textCapitalization: TextCapitalization.none,
                                  decoration: InputDecoration(
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                    hintText: 'Enter your Username',
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
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Please enter a valid username.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _username = value!;
                                    value = '';
                                  },
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  autocorrect: false,
                                  keyboardType: TextInputType.emailAddress,
                                  textCapitalization: TextCapitalization.none,
                                  decoration: InputDecoration(
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                    hintText: 'Enter your email',
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
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().isEmpty ||
                                        !value.contains('@')) {
                                      return 'Please enter a valid email address.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _enteredEmail = value!;
                                    value = '';
                                  },
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  autocorrect: false,
                                  obscureText: isobscure,
                                  textCapitalization: TextCapitalization.none,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isobscure = !isobscure;
                                        });
                                      },
                                      icon: Icon(isobscure
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                    ),
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground),
                                    hintText: 'Enter your Password',
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
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().length < 6) {
                                      return 'Password must be at least 6 characters long.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _enteredPassword = value!;
                                  },
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                if (_isAuthenticating)
                                  const CircularProgressIndicator(),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          143 -
                                          39,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width: 105,
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
                                            'Create Account',
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
                                SizedBox(
                                  height: 16,
                                ),
                                Center(
                                  child: SizedBox(
                                    width: 200,
                                    height: 40,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                            .withOpacity(0.1),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isLogin = !_isLogin;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.arrow_back,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                          Text(
                                            'Login',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ),
                                          ),
                                          SizedBox(
                                            width: 18,
                                          ),
                                          Text(
                                            'Have an account',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                  color: Colors.white,
                                                ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Image.asset(
                          'images/background.jpg',
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          );
  }
}
