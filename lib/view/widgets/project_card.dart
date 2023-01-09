import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:systemforschool/core/firebase/models/task.dart';
import 'package:systemforschool/utils/constants.dart';
import 'package:systemforschool/utils/styles.dart';
import 'package:systemforschool/view/blocs/task/task_bloc.dart';
import 'package:systemforschool/view/screens/tasks_screen.dart';
import 'package:systemforschool/view/widgets/user_icon.dart';
class ProjectCard extends StatefulWidget {
  const ProjectCard(
      {Key? key, required this.task, this.isOwner = false, this.isEditing = false,this.isMember=true})
      : super(key: key);
  final Task task;
  final bool isOwner;
  final bool isMember;
  final bool isEditing;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  late bool isEditing=widget.isEditing;
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.text = widget.task.name;
  }

  @override
  Widget build(BuildContext context) {
    int done = 0;
    for (var taskItem in widget.task.tasks) {
      if (taskItem.complete) {
        done++;
      }
    }
    return GestureDetector(
      onTap: () {
        if (!isEditing) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TasksScreen(
                        task: widget.task,
                        canModify: (widget.isMember||widget.isOwner),
                      )));
        }
      },
      child: Card(
        // padding: const EdgeInsets.all(10),
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   borderRadius: BorderRadius.circular(10),
        // ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  FutureBuilder(
                      future: widget.task.owner!.get(),
                      builder: (context, snapshot) {
                        return UserIcon((snapshot.data?["name"]) ?? "аа");
                      }),
                  // UserIcon(widget.task.owner.get().),
                  Expanded(child: SizedBox()),
                  widget.isOwner
                      ? PopupMenuButton<int>(
                    enabled: !isEditing,
                    icon: Icon(Icons.more_horiz_outlined),
                    onSelected: (index) {
                      if(index==0){

                        widget.task.reference.update({
                          'isPublic': widget.task.isPublic?false:true, // John Doe
                        });
                      }
                      else if (index == 1) {
                        setState(() {
                          isEditing = true;
                        });
                      } else if (index == 2) {
                        FirebaseFirestore.instance.runTransaction(
                                (transaction) async =>
                                transaction
                                    .delete(widget.task.reference));
                      }
                    },
                    itemBuilder: (context) =>
                    [
                      PopupMenuItem(
                        value: 0,
                        child: Text(widget.task.isPublic?"Сделать закрытым":"Сделать публичным"),
                      ),
                      PopupMenuItem(
                        value: 1,
                        child: Text("Редактировать"),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Text(
                          "Удалить",
                        ),
                      ),
                    ],
                    offset: Offset(0, 0),
                    color: Colors.white,
                    elevation: 8,
                  )
                      : PopupMenuButton<int>(
                    enabled:widget.isMember?true:false,
                    icon: Icon(Icons.more_horiz_outlined),
                    onSelected: (value) {
                      if (value == 1) {
                        widget.task.reference.update({
                          "members": FieldValue.arrayRemove([
                            "users/${FirebaseAuth.instance.currentUser!.uid}"
                          ])
                        });
                      }
                    },
                    itemBuilder: (context) =>
                    [
                      PopupMenuItem(
                        value: 1,
                        child: Text("Покинуть проект"),
                      ),
                      // popupmenu item 2
                    ],
                    offset: Offset(0, 0),
                    color: Colors.white,
                    elevation: 8,
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              SizedBox(
                height: 70,
                child: isEditing
                    ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: IntrinsicWidth(
                        child: TextFormField(
                            autofocus: true,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20),
                            ],
                            decoration: InputDecoration(
                                isDense: true,
                                contentPadding:
                                EdgeInsets.symmetric(vertical: 5)),
                            controller: textController,
                            style: Styles.headerStyle),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isEditing = false;
                          context.read<TaskBloc>().add(
                              ProjectEditingFinishedEvent());
                        });
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(
                            Icons.close,
                            color: Colors.red,
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (widget.isEditing) {
                          FirebaseFirestore.instance.collection("tasks")
                              .add({
                            'members': widget.task.members,
                            'date': widget.task.creationDate,
                            'name': textController.text, // John Doe
                            'owner': widget.task.owner, // Stokes and Sons
                            'isPublic':true,
                            'tasks': [] // 42
                          });
                        } else {
                          widget.task.reference.update({
                            'name': textController.text, // John Doe
                          });
                        }
                        setState(() {
                          isEditing = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Icon(
                          Icons.done,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                )
                    : Text(widget.task.name, style: Styles.headerStyle),
              ),
              const Spacer(),
              Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 13, vertical: 3),
                  decoration: BoxDecoration(
                    color: widget.task.isPublic?Colors.green:Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(widget.task.isPublic?"Public":"Private",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ))),
              Divider(
                color: Colors.black,
              ),
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 10),
                height: 20,
                child: Row(
                  children: [
                    Icon(
                      Icons.task_outlined,
                      color: Colors.grey.shade800,
                      size: 20,
                    ),
                    Text(
                      "$done/${widget.task.tasks.length}",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 20,
                        child: LinearPercentIndicator(
                          lineHeight: 4.0,
                          barRadius: Radius.circular(3),
                          percent: (done / widget.task.tasks.length),
                          backgroundColor: Colors.grey,
                          progressColor: AppConstants.primaryColor,
                        ),
                      ),
                    ),
                    Text(
                        "${widget.task.tasks.isNotEmpty ? ((done / widget.task
                            .tasks.length) * 100).round() : 0} %",
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
