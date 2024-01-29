import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  void _change() async {
    final isvalid = _form.currentState!.validate();

    if (!isvalid) {
      return;
    }
    _form.currentState!.save();
    User? user = await FirebaseAuth.instance.currentUser;
    try {
      user!.updatePassword(_newpassword).then((value) {
        print("Successfully changed password");
      }).catchError((error) {
        print("Password can't be changed" + error.toString());
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Password cannot be changed' + error.toString())));
      });
      setState(() {
        FirebaseAuth.instance.signOut();
      });
    } catch (e) {
      print('wrong');
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
                          onPressed: _change,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                          ),
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
