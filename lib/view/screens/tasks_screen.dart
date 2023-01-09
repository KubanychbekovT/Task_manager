import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:systemforschool/core/firebase/models/task_item.dart';
import 'package:systemforschool/utils/constants.dart';
import 'package:systemforschool/utils/styles.dart';
import 'package:systemforschool/view/blocs/task/task_bloc.dart';
import 'package:systemforschool/view/screens/members_screen.dart';
import 'package:systemforschool/view/widgets/custom_scaffold.dart';
import 'package:systemforschool/view/widgets/task_card.dart';

import '../../core/firebase/models/task.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key, required this.task,this.canModify=true}) : super(key: key);
  final Task task;
  final bool canModify;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      actions: [
        IconButton(
            onPressed: () {

              Navigator.push(context,

                  PageRouteBuilder(transitionDuration:Duration.zero,reverseTransitionDuration:Duration.zero,pageBuilder: (context,animation1,animation2) => MembersScreen(task)));
            },
            icon: Icon(Icons.more_horiz_outlined))
      ],
      appBarTitle: task.name,
      isScrolling: true,
      floatingActionButton: canModify?SizedBox(
        height: 50,
        width: 50,
        child: FloatingActionButton(
          backgroundColor: AppConstants.secondaryColor,
          onPressed: () {
            context.read<TaskBloc>().add(TaskEditingStartedEvent());
          },
          child: const Icon(Icons.add),
        ),
      ):null,
      body: StreamBuilder(
          stream: task.reference.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data?.data()?.tasks != null &&
                snapshot.data!.data()!.tasks.isNotEmpty) {
              double percentage = 0;
              List<TaskItem> taskItems = snapshot.data!.data()!.tasks;
              taskItems
                  .sort((a, b) => a.creationDate.compareTo(b.creationDate));
              for (var a in taskItems) {
                percentage += a.complete ? 1 : 0;
              }
              percentage = (percentage / taskItems.length);
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ...[
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Прогресс ${(percentage * 100).round()} %",
                        style: Styles.titleStyle,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 150),
                        alignment: Alignment.center,
                        child: LinearPercentIndicator(
                          lineHeight: 14.0,
                          barRadius: Radius.circular(3),
                          percent: percentage,
                          backgroundColor: Colors.grey,
                          progressColor: AppConstants.primaryColor,
                        ),
                      ),
                      for (var taskItem in taskItems) ...[
                        TaskCard(
                          taskItem: taskItem,
                          documentReference: task.reference,
                          canModify: canModify,
                          ownerReference: task.owner!.path,
                        ),
                      ],
                      BlocBuilder<TaskBloc, TaskState>(
                        builder: (context, state) {
                          if (state is TaskEditingStartedState) {
                            return TaskCard(
                                taskItem: TaskItem(
                                    itemName: "",
                                    creationDate:
                                        Timestamp.fromDate(DateTime.now()),
                                    owner: "",
                                    complete: false),
                                isEditing: true,
                                documentReference: task.reference);
                          }
                          return const SizedBox();
                        },
                      )
                    ]
                  ],
                ),
              );
            } else {
              return BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if (state is TaskEditingStartedState) {
                    return TaskCard(
                        taskItem: TaskItem(
                            itemName: "",
                            owner: "",
                            creationDate: Timestamp.fromDate(DateTime.now()),
                            complete: false),
                        isEditing: true,
                        documentReference: task.reference);
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.assignment,
                          size: 128,
                          color: Colors.grey,
                        ),
                        Text(
                          "Нет задач",
                          style: Styles.bodyStyle,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
