import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:systemforschool/view/blocs/task/task_bloc.dart';
import 'package:systemforschool/view/screens/navbar_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:systemforschool/view/screens/reg_screen.dart';
class App extends StatelessWidget {

  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return SignInScreen(
        providers: [EmailAuthProvider()],
        actions: [
          AuthStateChangeAction<SigningUp>((context,state) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>RegScreen()),(Route<dynamic> route) => false);
          }),
          AuthStateChangeAction<SignedIn>((context, state) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>App()),(Route<dynamic> route) => false);
          }),
        ],
      );
    } else {
      return NavbarScreen();
    }
  }
}