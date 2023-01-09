import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:systemforschool/app.dart';
import 'package:systemforschool/utils/constants.dart';
import 'package:systemforschool/utils/styles.dart';
import 'package:systemforschool/view/widgets/custom_scaffold.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(appBarTitle:"Профиль",body: Center(child:SizedBox(width:MediaQuery.of(context).size.width-80,height:36,child: ElevatedButton(onPressed: (){
      FirebaseAuth.instance.signOut().then((value) => {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>App()), (route) => false)
      });
    }, child: Text("Выйти",style: Styles.buttonStyle,),style: ElevatedButton.styleFrom(primary: AppConstants.primaryColor),))));
  }
}
