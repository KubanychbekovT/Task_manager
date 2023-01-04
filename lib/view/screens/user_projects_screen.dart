import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                    return Column(
                      children: [
                        for (var document in snapshot.data!.docs) ...[
                          ProjectCard(
                              task: document.data(),
                              documentReference: document.reference),
                        ]
                      ],
                    );
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

