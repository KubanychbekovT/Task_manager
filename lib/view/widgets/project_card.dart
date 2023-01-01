import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:systemforschool/core/firebase/models/task.dart';
import 'package:systemforschool/utils/constants.dart';
import 'package:systemforschool/view/screens/tasks_screen.dart';

class ProjectCard extends StatelessWidget {
  ProjectCard({Key? key ,required this.task, required this.documentReference}) : super(key: key);
  Task task;
  DocumentReference<Task> documentReference;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyProjectsDetailScreen(
                      task: task!,
                      documentReference: documentReference,
                    )));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: 70,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: AppConstants.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Icon(
                       Icons.account_tree_outlined
                           ,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      task!.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(child: Container()),

                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
