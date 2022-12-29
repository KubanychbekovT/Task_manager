import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:systemforschool/core/firebase/models/task_item.dart';
import 'package:systemforschool/view/screens/add_task_screen.dart';
import 'package:systemforschool/view/widgets/ProgressCard.dart';

class MyProjectsDetailScreen extends StatelessWidget {
  MyProjectsDetailScreen({Key? key,required this.taskItems}) : super(key: key);
  List<TaskItem> taskItems;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: SizedBox(
          height: 50,
          width: 50,
          child: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 123, 0, 245),
            onPressed: () {

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                      const AddProjectsScreen()));
            },
            child: const Icon(Icons.add),
          ),
        ),
        backgroundColor: Color.fromRGBO(242, 244, 255, 1),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Задачи проекта",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        for(var document in taskItems)...[
                          ProgressCard(
                            taskItem: document,),
                        ]
                      ],
                    )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
