import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:systemforschool/core/firebase/models/task_item.dart';
import 'package:systemforschool/utils/constants.dart';
import 'package:systemforschool/utils/styles.dart';
import 'package:systemforschool/view/blocs/task/task_bloc.dart';
import 'package:systemforschool/view/screens/item_screen.dart';
import 'package:systemforschool/view/widgets/custom_scaffold.dart';
import 'package:systemforschool/view/widgets/task_card.dart';

import '../../core/firebase/models/task.dart';

class MyProjectsDetailScreen extends StatelessWidget {
  MyProjectsDetailScreen({Key? key, required this.documentReference,required this.task})
      : super(key: key);
  DocumentReference<Task> documentReference;
  Task task;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      actions: [   PopupMenuButton<int>(
        onSelected: (index){
          if(index==1){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItemScreen(
                          isProject: true,
                          documentReference: documentReference,
                          task:task
                      )));
          }else if(index==2){
              FirebaseFirestore.instance.runTransaction((transaction) async =>
                  transaction.delete(documentReference));
              Navigator.pop(context);
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
      ),],
      appBarTitle: task.name,
      floatingActionButton: SizedBox(
        height: 50,
        width: 50,
        child: FloatingActionButton(
          backgroundColor: AppConstants.secondaryColor,
          onPressed: () {
            context.read<TaskBloc>().add(EditingStartedEvent());
          },
          child: const Icon(Icons.add),
        ),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(buildWhen: (context, state) {
        if (state is TasksStreamLoaded) {
          return true;
        }
        return false;
      }, builder: (context, state) {
        if (state is TasksStreamLoaded) {
          return StreamBuilder(
              stream: documentReference.snapshots(),
              builder: (context, snapshot) {
                  if(snapshot.data?.data()?.tasks!=null&&snapshot.data!.data()!.tasks.isNotEmpty){
                    double percentage=0;
                    List<TaskItem> taskItems=snapshot.data!.data()!.tasks;
                    taskItems.sort((a,b)=>a.creationDate.compareTo(b.creationDate));
                    for(var a in taskItems){
                      percentage+=a.complete?1:0;
                    }
                    percentage=(percentage/taskItems.length);
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ...[
                          SizedBox(height: 20,),
                          Text("Прогресс ${(percentage*100).round()} %",style: Styles.headerStyle,),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 150 ),
                            alignment: Alignment.center,
                            child: LinearPercentIndicator(
                              lineHeight: 14.0,
                              barRadius: Radius.circular(3),
                              percent: percentage,
                              backgroundColor: Colors.grey,
                              progressColor: AppConstants.primaryColor,
                            ),
                          ),
                          for (var taskItem in taskItems)...[
                            TaskCard(
                              taskItem: taskItem,
                              documentReference: documentReference,
                            ),
                          ],
                          BlocBuilder<TaskBloc, TaskState>(
  builder: (context, state) {
    if(state is EditingStartedState){
      return TaskCard(taskItem: TaskItem(itemName: "",creationDate: Timestamp.fromDate(DateTime.now()),complete: false),isEditing: true, documentReference: documentReference);
    }
    return const SizedBox();
  },
)

                        ]
                      ],
                    );
                  }
                  else {
                    return BlocBuilder<TaskBloc, TaskState>(
  builder: (context, state) {

        if(state is EditingStartedState){
          return TaskCard(taskItem: TaskItem(itemName: "",creationDate: Timestamp.fromDate(DateTime.now()),complete: false),isEditing: true, documentReference: documentReference);
        }
    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.assignment, size: 128, color: Colors
                              .grey,),
                          Text("Нет задач", style: Styles.bodyStyle,
                            textAlign: TextAlign.center,)
                        ],),
                    );
  },
);
                  }
              });
        }
        return Text(
          "Not found",
          style: TextStyle(fontSize: 40),
        );
      }),
    );
  }
}
