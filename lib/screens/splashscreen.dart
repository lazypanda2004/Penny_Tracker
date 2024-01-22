import 'package:flutter/material.dart';

class splashscreen extends StatefulWidget {
  splashscreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _splashscreenstate();
  }
}

class _splashscreenstate extends State<splashscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PT'),
      ),
      body: Center(
        child: Text('loading'),
      ),
    );
  }
}
