import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pt/screens/auth.dart';

class passwordchange extends StatefulWidget {
  passwordchange({super.key, required this.id});
  final String id;
  @override
  State<passwordchange> createState() {
    return _passwordchangestate();
  }
}

class _passwordchangestate extends State<passwordchange> {
  final _form = GlobalKey<FormState>();
  var isobscure = true;
  var _newpassword = '';
  var _oldpassword = '';
  var emaill = '';
  var curuser = FirebaseAuth.instance.currentUser;

  User user = FirebaseAuth.instance.currentUser!;
  String id = FirebaseAuth.instance.currentUser!.uid;

  _change({email, oldpassword, newpassword}) async {
    final isvalid = _form.currentState!.validate();
    if (!isvalid) {
      return;
    }
    _form.currentState!.save();
    var cred =
        EmailAuthProvider.credential(email: emaill, password: _oldpassword);
    await curuser!.reauthenticateWithCredential(cred).then((value) async {
      await curuser!.updatePassword(_newpassword);
      FirebaseAuth.instance.signOut();
    }).catchError((error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Password Change failed.'),
        ),
      );
    });
    if (mounted) {
      Navigator.of(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return const Authscreen();
        }),
      );
    }
  }

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
            'Password Change',
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Center(
              child: Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      autocorrect: false,
                      obscureText: isobscure,
                      keyboardType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
                      decoration: InputDecoration(
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                        hintText: 'Enter your Email',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onBackground,
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
                        emaill = value!;
                        value = '';
                      },
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
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                        hintText: 'Enter your Old Password',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onBackground,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().length < 6) {
                          return 'Old Password must be at least 6 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _oldpassword = value!;
                        value = '';
                      },
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
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                        hintText: 'Enter your New Password',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onBackground,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().length < 6) {
                          return 'Password must be at least 6 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newpassword = value!;
                        value = '';
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: SizedBox(
                        width: 267,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            await _change(
                                email: emaill,
                                oldpassword: _oldpassword,
                                newpassword: _newpassword);
                          },
                          child: Text(
                            'Reset Password',
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
