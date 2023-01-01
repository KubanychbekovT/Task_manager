import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:systemforschool/core/firebase/models/task.dart';
import 'package:systemforschool/utils/constants.dart';
import 'package:systemforschool/utils/styles.dart';
import 'package:systemforschool/view/screens/tasks_screen.dart';
import 'package:systemforschool/view/widgets/custom_scaffold.dart';
import 'package:systemforschool/view/widgets/project_card.dart';

import '../blocs/task/task_bloc.dart';
import '../widgets/task_card.dart';
import 'item_screen.dart';

class MyProjectsScreen extends StatelessWidget {
  MyProjectsScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
       appBarTitle: "Проекты",
      floatingActionButton: SizedBox(
        height: 50,
        width: 50,
        child: FloatingActionButton(
          backgroundColor: AppConstants.secondaryColor,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ItemScreen(
                      isProject: true,
                    )));
          },
          child: const Icon(Icons.add),
        ),
      ),
      body: BlocBuilder<TaskBloc,TaskState>(
          buildWhen: (context,state){
            if(state is TasksStreamLoaded){
              return true;
            }
            return false;
          },
          builder: (context,state){
            if(state is TasksStreamLoaded){
              return StreamBuilder(stream:state.tasksCollection.snapshots(),builder:(context,snapshot){
                if((snapshot.data?.docs)!=null&&snapshot.data!.docs.isNotEmpty){
                  return Column(children: [
                    for(var document in snapshot.data!.docs)...[
                      ProjectCard(
                          task: document.data(),documentReference: document.reference),
                    ]
                  ],
                  );
                }
               else {
                 return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_tree_outlined, size: 128, color: Colors
                            .grey,),
                        Text("Нет проектов", style: Styles.bodyStyle,
                          textAlign: TextAlign.center,)
                      ],),
                  );
                }});
            }
            return Text("Not found",style: TextStyle(fontSize: 40),);
          }),
    );
  }
}
