import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:systemforschool/app.dart';
import 'package:systemforschool/utils/firebase_options.dart';
import 'package:systemforschool/utils/router_config.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      App()
  );
}


