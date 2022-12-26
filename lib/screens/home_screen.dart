import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key, required this.label}) : super(key: key);

  String label;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:ElevatedButton(onPressed: () { FirebaseAuth.instance.signOut(); },
        child: Text("Log out"),),
      ),
    );
  }
}
