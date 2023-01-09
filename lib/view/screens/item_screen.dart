import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:systemforschool/core/firebase/models/task_item.dart';
import 'package:systemforschool/core/firebase/services/firebase_service.dart';
import 'package:systemforschool/utils/constants.dart';
import 'package:systemforschool/utils/styles.dart';
import 'package:systemforschool/view/blocs/task/task_bloc.dart';
import 'package:systemforschool/view/widgets/custom_scaffold.dart';

import '../../core/firebase/models/task.dart';

class ItemScreen extends StatelessWidget {
  ItemScreen({Key? key,required this.isProject,this.taskItem,this.task,this.documentReference}) : super(key: key);
  DocumentReference<Task>? documentReference;
  TaskItem? taskItem;
  Task? task;
  bool isProject;
  TextEditingController editingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    editingController.text=(isProject?task?.name:taskItem?.itemName)??"";
    return CustomScaffold(
      appBarTitle:  isProject?(task!=null?"Редактирование проекта":"Новый проект"):(taskItem!=null?"Редактирование задачи":"Новая задача"),
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
                inputFormatters: [
                  LengthLimitingTextInputFormatter(20),
                ],
                maxLines: 8,
                cursorColor: Colors.black26,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  labelText: "Название",
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
                if(isProject){
                  DocumentReference document=FirebaseFirestore.instance.doc("users/${FirebaseAuth.instance.currentUser!.uid}");
                  if(task==null){
                    FirebaseFirestore.instance.collection("tasks")
                        .add({
                      'members':[document.path],
                      'name': editingController.text, // John Doe
                      'owner': document, // Stokes and Sons
                      'tasks': [] // 42
                    });
                  }
                  else{
                   task!.reference!.update({
                      'name': editingController.text, // John Doe
                    });
                   Navigator.pop(context);
                  }
                }else{
                  if(taskItem==null){
                    documentReference!.update({"tasks":FieldValue.arrayUnion([{"complete":false,"itemName":editingController.text,"date":DateTime.now()}])});
                  }else{
                  }
                }
                Navigator.pop(context);
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
                  (taskItem==null&&task==null)?"Создать":"Редактировать",
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
