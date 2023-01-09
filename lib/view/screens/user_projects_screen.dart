import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:systemforschool/core/firebase/models/task.dart';
import 'package:systemforschool/core/firebase/models/user.dart';
import 'package:systemforschool/utils/styles.dart';
import 'package:systemforschool/view/blocs/task/task_bloc.dart';
import 'package:systemforschool/view/widgets/custom_scaffold.dart';

import '../widgets/project_card.dart';

class UserProjectsScreen extends StatelessWidget {
  const UserProjectsScreen(this.user, {Key? key}) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    context.read<TaskBloc>().add(LoadOwnerTasksEvent(user.reference));
    return CustomScaffold(appBarTitle: user.name, body: Center(
        child: BlocBuilder<TaskBloc, TaskState>(buildWhen:(context,state){
      if (state is LoadOwnerTasksState) {
        return true;
      }
      return false;
      },builder: (context, state) {
          if (state is LoadOwnerTasksState) {
            return StreamBuilder(
                stream: state.tasksCollection.snapshots(),
                builder: (context, snapshot) {
                  if ((snapshot.data?.docs) != null &&
                      snapshot.data!.docs.isNotEmpty) {
    return LayoutBuilder(builder: (context, constraints)
    {
      List<Task> projectList=List.generate(snapshot.data!.docs.length, (index) => snapshot.data!.docs[index].data());
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
            bool isMember=false;
            for(var member in projectList[index].members){
              if(member=="users/${FirebaseAuth.instance.currentUser!.uid}"){
                isMember=true;
                break;
              }
            }
            return ProjectCard(
              isEditing: projectList[index].name.isEmpty,
              task: projectList[index],
              isMember: isMember,
            );
          });
    });
                    // return Column(
                    //   children: [
                    //     // for (var document in snapshot.data!.docs) ...[
                    //     //   ProjectCard(
                    //     //       task: document.data(),
                    //     //       ),
                    //     // ]
                    //   ],
                    // );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_tree_outlined,
                            size: 128,
                            color: Colors.grey,
                          ),
                          Text(
                            "Нет проектов",
                            style: Styles.bodyStyle,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    );
                  }
                });
          }
          return SizedBox();
        })));
  }
}

