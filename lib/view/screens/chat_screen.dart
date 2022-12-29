import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key, required this.label}) : super(key: key);

  String label;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(label),
      ),
    );
  }
}
