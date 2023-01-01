import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:systemforschool/app.dart';
import 'package:systemforschool/core/firebase/models/task_item.dart';
import 'package:systemforschool/core/firebase/services/tasks_service.dart';
import 'package:systemforschool/utils/constants.dart';
import 'package:systemforschool/utils/styles.dart';
import 'package:systemforschool/view/blocs/task/task_bloc.dart';
import 'package:systemforschool/view/widgets/custom_scaffold.dart';

import '../../core/firebase/models/task.dart';

class RegScreen extends StatelessWidget {
  RegScreen({Key? key}) : super(key: key);
  TextEditingController editingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    editingController.text="";
    return CustomScaffold(
      appBarTitle: "Создание аккаунта",
      body: Container(
        height: 150,
        margin: EdgeInsets.symmetric(horizontal: 25,vertical: 5),
        clipBehavior: Clip.antiAlias,
        padding:
            EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: TextFormField(
                controller: editingController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 8,
                cursorColor: Colors.black26,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  labelText: "Имя",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26),
                  ),
                  fillColor: Colors.black26,
                  labelStyle: TextStyle(
                    color: Colors.black26,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid)
                    .set({
                  'name': editingController.text, // John Doe
                  'email': FirebaseAuth.instance.currentUser!.email
                });
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>App()),(Route<dynamic> route) => false);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppConstants.primaryColor,
                ),
                alignment: Alignment.center,
                child: Text(
                  "Продолжить",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
