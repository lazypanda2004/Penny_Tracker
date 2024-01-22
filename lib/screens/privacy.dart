import 'package:flutter/material.dart';

class privacy extends StatelessWidget {
  const privacy({super.key});
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
            'Privacy Policy',
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
        body: Center(
          child: Text(
            'Mundhu aithe migathavi complete chey ra time ledhu',
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
      ),
    );
  }
}
