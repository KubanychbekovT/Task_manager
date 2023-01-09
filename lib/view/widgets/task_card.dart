import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:systemforschool/core/firebase/models/task.dart';
import 'package:systemforschool/core/firebase/models/task_item.dart';
import 'package:systemforschool/utils/constants.dart';

import '../blocs/task/task_bloc.dart';

class TaskCard extends StatefulWidget {
  const TaskCard(
      {Key? key,
      required this.taskItem,
      required this.documentReference,
      this.canModify = true,
      this.ownerReference = "",
      this.isEditing = false})
      : super(key: key);
  final TaskItem taskItem;
  final bool canModify;
  final String ownerReference;
  final bool isEditing;
  final DocumentReference<Task> documentReference;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late bool isEditing = widget.isEditing;
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    textController.text = widget.taskItem.itemName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
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
                  child: Icon(Icons.assignment, color: Colors.white),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (widget.isEditing) ...[
                  IntrinsicWidth(
                    child: TextField(
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5)),
                      controller: textController,
                      autofocus: true,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ] else ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.taskItem.itemName,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                        //
                        // Text(
                        //   "Ilgiz",
                        //   style: TextStyle(
                        //     color: Colors.grey,
                        //     fontSize: 14,
                        //     fontWeight: FontWeight.w400,
                        //   ),
                        // )
                    ],
                  ),
                  // Text(
                  //   widget.taskItem.itemName,
                  //   style: const TextStyle(
                  //     color: Colors.black,
                  //     fontSize: 15,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                ],
                Expanded(child: Container()),
                if (widget.isEditing) ...[
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            context
                                .read<TaskBloc>()
                                .add(TaskEditingFinishedEvent());
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.red,
                          )),
                      IconButton(
                          onPressed: () {
                            widget.documentReference.update({
                              "tasks": FieldValue.arrayRemove([
                                {
                                  "complete": widget.taskItem.complete,
                                  "itemName": widget.taskItem.itemName,
                                  "owner":widget.taskItem.owner,
                                  "date": widget.taskItem.creationDate
                                }
                              ])
                            });
                            widget.documentReference.update({
                              "tasks": FieldValue.arrayUnion([
                                {
                                  "complete": widget.taskItem.complete,
                                  "itemName": textController.text,
                                  "owner":widget.taskItem.owner,
                                  "date": widget.taskItem.creationDate
                                }
                              ])
                            });
                            setState(() {
                              isEditing = false;
                            });
                            context
                                .read<TaskBloc>()
                                .add(TaskEditingFinishedEvent());
                          },
                          icon: Icon(
                            Icons.done,
                            color: Colors.green,
                          )),
                    ],
                  )
                ] else ...[
                  Row(
                    children: [
                      Visibility(
                        visible: widget.canModify,
                        child: Checkbox(
                            value: widget.taskItem.complete,
                            onChanged: (value) {
                              widget.documentReference.update({
                                "tasks": FieldValue.arrayRemove([
                                  {
                                    "complete": widget.taskItem.complete,
                                    "itemName": widget.taskItem.itemName,
                                    "owner":widget.taskItem.owner,
                                    "date": widget.taskItem.creationDate
                                  }
                                ])
                              });
                              widget.documentReference.update({
                                "tasks": FieldValue.arrayUnion([
                                  {
                                    "complete": value,
                                    "owner":widget.taskItem.owner,
                                    "itemName": widget.taskItem.itemName,
                                    "date": widget.taskItem.creationDate
                                  }
                                ])
                              });
                            }),
                      ),
                      Visibility(
                        visible: widget.canModify,
                        child: PopupMenuButton<int>(
                          onSelected: (index) {
                            if (index == 1) {
                              setState(() {
                                isEditing = true;
                              });
                            } else if (index == 2) {
                              var a = {
                                "complete": widget.taskItem.complete,
                                "owner":widget.taskItem.owner,
                                "itemName": widget.taskItem.itemName,
                                "date": widget.taskItem.creationDate,
                              };
                              widget.documentReference.update({
                                "tasks": FieldValue.arrayRemove([a])
                              });
                            }
                          },
                          itemBuilder: (context) => [
                            if(widget.ownerReference=="users/${FirebaseAuth.instance.currentUser!.uid}")
                            PopupMenuItem(
                              value: 0,
                              child: Text("Закрепить"),
                            ),
                            PopupMenuItem(
                              value: 1,
                              child: Text("Редактировать"),
                            ),
                            // popupmenu item 2
                            PopupMenuItem(
                              value: 2,
                              // row has two child icon and text
                              child: Text(
                                "Удалить",
                              ),
                            ),
                          ],
                          offset: Offset(0, 0),
                          color: Colors.white,
                          elevation: 8,
                        ),
                      ),
                    ],
                  )
                ]
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
