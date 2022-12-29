import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:systemforschool/core/firebase/models/task.dart';
import 'package:systemforschool/core/firebase/models/task_item.dart';
import 'package:systemforschool/view/screens/my_projects_detail_screen.dart';

class ProgressCard extends StatelessWidget {
  ProgressCard(
      {Key? key, this.task,this.taskItem})
      : super(key: key);
  Task? task;
TaskItem? taskItem;
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: (){
          if(task!=null){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProjectsDetailScreen(taskItems:task!.tasks)));
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: 70,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color:Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child:  Icon(task==null?Icons.assignment:Icons.account_tree_outlined, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        task!=null?task!.name:taskItem!.itemName,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "2 days ago",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  Expanded(child: Container()),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                        icon: Icon(Icons.edit, color: Colors.deepPurple,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection("tasks")
                                .doc("LUEw97Dnwk6haGZNPHCe").update({"tasks":FieldValue.arrayRemove([{"complete":false,"itemName":"Do appBar","owner":""}])});
                            // FirebaseFirestore.instance.runTransaction((transaction) async =>
                            // await transaction.delete(task.reference!));
                          },
                          icon: Icon(Icons.delete, color: Colors.red,
                          ),
                      ),
                    ],
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
