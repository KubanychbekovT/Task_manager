import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:systemforschool/core/firebase/models/task.dart';
import 'package:systemforschool/utils/constants.dart';
import 'package:systemforschool/view/widgets/custom_scaffold.dart';
import 'package:systemforschool/view/widgets/project_card.dart';
import 'package:systemforschool/view/widgets/result_card.dart';

import '../blocs/task/task_bloc.dart';
import 'item_screen.dart';

class MyProjectsScreen extends StatelessWidget {
  MyProjectsScreen({
    Key? key,
  }) : super(key: key);
  int _value = 1;
  final List<String> filterList = [
    "Все проекты",
    "Мои проекты",
    "Рабочие проекты"
  ];

  @override
  Widget build(BuildContext context) {
    context.read<TaskBloc>().add(LoadTasksEvent());
    return CustomScaffold(
      actions: [
        BlocBuilder<TaskBloc, TaskState>(
          buildWhen: (context, state) {
            if (state is ChangeFilterState) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            return DropdownButtonHideUnderline(
              child: DropdownButton(
                focusColor: Colors.transparent,
                selectedItemBuilder: (context) {
                  return filterList.map((String value) {
                    return Center(
                      child: Text(
                        filterList[_value-1],
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList();
                },
                icon: Icon(
                  Icons.expand_more_outlined,
                  color: Colors.white,
                ),
                value: _value,
                items: <DropdownMenuItem<int>>[
                  DropdownMenuItem(
                    child: Text(filterList[0]),
                    value: 1,
                  ),
                  DropdownMenuItem(child: Text(filterList[1]), value: 2),
                  DropdownMenuItem(value: 3, child: Text(filterList[2])),
                ],
                onChanged: (newVal) {
                    context
                        .read<TaskBloc>()
                        .add(ChangeFilterEvent(category: newVal!));
                  _value = int.parse(newVal.toString());
                },
              ),
            );
          },
        )
      ],
      appBarTitle: "Проекты",
      floatingActionButton: SizedBox(
        height: 50,
        width: 50,
        child: FloatingActionButton(
          backgroundColor: AppConstants.secondaryColor,
          onPressed: () {
           context.read<TaskBloc>().add(ProjectEditingStartedEvent());
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
              stream: state.tasksCollection.snapshots(),
              builder: (context, snapshot) {
                if ((snapshot.data?.docs) != null ) {
                  final List<Task> projectList = [];
                 projectList.addAll(filterCollection(_value, snapshot));
                  return BlocConsumer<TaskBloc, TaskState>(
                    buildWhen: (context, state) {
                      if (state is ChangeFilterState||state is ProjectEditingStartedState||state is ProjectEditingFinishedState) {
                        return true;
                      }
                      return false;
                    },
                    listener: (context, state) {
                      if (state is ChangeFilterState) {
                        projectList.clear();
                        projectList.addAll(filterCollection(state.category, snapshot));
                      }
                      else if(state is ProjectEditingStartedState){
                        if(projectList.isEmpty||projectList.last.name.isNotEmpty){
                          String uid="users/${FirebaseAuth.instance.currentUser!.uid}";
                          projectList.add(Task(name: "",tasks: [],isPublic:true,owner: FirebaseFirestore.instance.doc(uid),members: [uid],creationDate:  Timestamp.fromDate(DateTime.now())));
                        }
                     }else if(state is ProjectEditingFinishedState){
                        if(projectList.last.name.isEmpty){
                          projectList.removeLast();
                        }
                      }
                    },
                    builder: (context, state) {
                      if(projectList.isNotEmpty){
                        print("isNotEmpty");
                        return LayoutBuilder(builder: (context, constraints) {
                          return GridView.builder(
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                constraints.maxWidth > 700 ? 4 : 2,
                                mainAxisSpacing: 10,
                                mainAxisExtent: 256,
                                crossAxisSpacing: 10,
                              ),
                              itemCount: projectList.length,
                              itemBuilder: (context, index) {
                                bool isOwner = projectList[index].owner!.path ==
                                    "users/${FirebaseAuth.instance.currentUser!.uid}";
                                return ProjectCard(
                                  isEditing: projectList[index].name.isEmpty,
                                  task: projectList[index],
                                  isOwner: isOwner,
                                );
                              });
                        });
                      }else{
                        print("isEmpty");
                        return ResultCard(
                            "Нет проектов", Icons.account_tree_outlined);
                      }


                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator(color: AppConstants.secondaryColor,));
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
  List<Task> filterCollection(int category,snapshot){
    final List<Task> projectList=[];
    for (var element in snapshot.data!.docs) {
      bool isOwner = element.data().owner!.path ==
          "users/${FirebaseAuth.instance.currentUser!.uid}";
      if ((category == 2 && isOwner)) {
        projectList.add(element.data());
      } else if (category == 3 && !isOwner) {
        projectList.add(element.data());
      } else if (category == 1) {
        projectList.add(element.data());
      }
    }
    projectList
        .sort((a, b) => a.creationDate.compareTo(b.creationDate));
    return projectList;
  }
}
