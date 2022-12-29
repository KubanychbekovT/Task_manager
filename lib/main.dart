import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:systemforschool/utils/firebase_options.dart';
import 'package:systemforschool/view/blocs/task/task_bloc.dart';
import 'package:systemforschool/view/screens/scaffold_with_bottom_navbar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    //  name: "School System",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      const App()
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(),
      child: MaterialApp(
        home: ScaffoldWithBottomNavBar(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
