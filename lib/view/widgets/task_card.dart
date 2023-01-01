import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:systemforschool/core/firebase/models/task.dart';
import 'package:systemforschool/core/firebase/models/task_item.dart';
import 'package:systemforschool/utils/constants.dart';
import 'package:systemforschool/utils/styles.dart';
import 'package:systemforschool/view/screens/item_screen.dart';
import 'package:systemforschool/view/screens/tasks_screen.dart';

import '../blocs/task/task_bloc.dart';

class TaskCard extends StatefulWidget {
  TaskCard(
      {Key? key, required this.taskItem, required this.documentReference,this.isEditing=false})
      : super(key: key);
  TaskItem taskItem;
  bool isEditing;
  DocumentReference<Task> documentReference;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  TextEditingController textController=TextEditingController();
  @override
  void initState() {
    textController.text=widget.taskItem.itemName;
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
                  child: Icon(
                    Icons.assignment,
                      color: Colors.white),
                ),
                const SizedBox(
                  width: 10,
                ),
               if(widget.isEditing)...[
    IntrinsicWidth(
    child: TextField(
    decoration: InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 20)
    ),
    controller: textController,
    autofocus: true,
    style: const TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    ),
    ),
    )
               ]else...[
                 Text(
                   widget.taskItem.itemName,
                   style: const TextStyle(
                     color: Colors.black,
                     fontSize: 15,
                     fontWeight: FontWeight.w500,


                   ),),
               ],
                Expanded(child: Container()),
               if(widget.isEditing)...[    Row(children: [
    IconButton(onPressed: (){
    context.read<TaskBloc>().add(LoadTasksEvent());
    }, icon: Icon(Icons.close,color: Colors.red,)),
    IconButton(onPressed: (){
    widget.documentReference!.update({"tasks":FieldValue.arrayRemove([{"complete":widget.taskItem!.complete,"itemName":widget.taskItem!.itemName,"date":widget.taskItem!.creationDate}])});
    widget.documentReference!.update({"tasks":FieldValue.arrayUnion([{"complete":false,"itemName":textController.text,"date":widget.taskItem!.creationDate}])});
    setState(() {
      widget.isEditing=false;
    });
    context.read<TaskBloc>().add(LoadTasksEvent());
    }, icon: Icon(Icons.done,color: Colors.green,)),

    ],)
               ]else...[
                 Row(
                   children: [

                     Checkbox(value: widget.taskItem.complete, onChanged: (value){
                       widget.documentReference.update({"tasks":FieldValue.arrayRemove([{"complete":widget.taskItem.complete,"itemName":widget.taskItem.itemName,"date":widget.taskItem.creationDate}])});
                       widget.documentReference.update({"tasks":FieldValue.arrayUnion([{"complete":value,"itemName":widget.taskItem.itemName,"date":widget.taskItem.creationDate}])});
                       context.read<TaskBloc>().add(LoadTasksEvent());
                     }),
                     PopupMenuButton<int>(
                       onSelected: (index){
                         if(index==1){
                           setState(() {
                             widget.isEditing=true;
                           });
                         }else if(index==2){
                           var a = {
                             "complete": widget.taskItem.complete,
                             "itemName": widget.taskItem.itemName,
                             "date": widget.taskItem.creationDate,
                           };
                           widget.documentReference.update({
                             "tasks": FieldValue.arrayRemove([a])
                           });
                           context.read<TaskBloc>().add(LoadTasksEvent());
                         }
                       },
                       itemBuilder: (context) => [

                         PopupMenuItem(
                           value: 1,
                           child: Text("Редактировать"),
                         ),
                         // popupmenu item 2
                         PopupMenuItem(
                           value: 2,
                           // row has two child icon and text
                           child: Text("Удалить",style: Styles.buttonStyle,),
                         ),
                       ],
                       offset: Offset(0, 0),
                       color: Colors.white,
                       elevation: 8,
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
