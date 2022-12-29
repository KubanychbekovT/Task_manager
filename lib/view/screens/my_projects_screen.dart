import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:systemforschool/utils/constants.dart';
import 'package:systemforschool/view/screens/my_projects_detail_screen.dart';

import '../blocs/task/task_bloc.dart';
import '../widgets/ProgressCard.dart';
import 'add_task_screen.dart';

class MyProjectsScreen extends StatelessWidget {
  MyProjectsScreen({
    Key? key,
  }) : super(key: key);
  bool isFirst=true;
  @override
  Widget build(BuildContext context) {
    if(isFirst){
      context.read<TaskBloc>().add(LoadTasksEvent());
      isFirst=false;
    }
    return SafeArea(
      child: Scaffold(
        floatingActionButton: SizedBox(
          height: 50,
          width: 50,
          child: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 123, 0, 245),
            onPressed: () {
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
                    "Проекты",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: BlocBuilder<TaskBloc,TaskState>(
                        buildWhen: (context,state){
                          if(state is TasksStreamLoaded){
                            return true;
                          }
                          return false;
                        },
                        builder: (context,state){
                          if(state is TasksStreamLoaded){
                            return StreamBuilder(stream:state.tasksCollection.snapshots(),builder:(context,snapshot){
                              return
                              Column(
                                children: [
                                  if((snapshot.data?.docs)!=null)...[
                                    for(var document in snapshot.data!.docs)...[
                              ProgressCard(
                                          task: document.data(),),

                              ]
                              ]
                                ],
                              );});
                          }
                          return Text("Not found",style: TextStyle(fontSize: 40),);
                        }),
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
