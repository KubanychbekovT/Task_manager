import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:systemforschool/app.dart';
import 'package:systemforschool/utils/firebase_options.dart';
import 'package:systemforschool/view/blocs/task/task_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    // name: "School System",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(BlocProvider(
    create: (context) => TaskBloc(),
    child: const MaterialApp(home: App(),debugShowCheckedModeBanner: false,),
  ));
}
