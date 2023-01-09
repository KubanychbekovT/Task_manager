import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:systemforschool/core/firebase/models/task.dart';
import 'package:systemforschool/core/firebase/models/user.dart';
import 'package:systemforschool/utils/styles.dart';
import 'package:systemforschool/view/widgets/custom_scaffold.dart';
import 'package:systemforschool/view/widgets/result_card.dart';
import 'package:systemforschool/view/widgets/user_card.dart';

import '../blocs/task/task_bloc.dart';

class MembersScreen extends StatefulWidget {
  MembersScreen(this.task, {Key? key}) : super(key: key);
  Task task;

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  List<QueryDocumentSnapshot<User>> userList = [];
  List<QueryDocumentSnapshot<User>> userSearchList = [];
  FocusNode focusNode = FocusNode();
  TextEditingController textEditingController = TextEditingController();
  bool isSearching = false;
  late final bool isAdmin;
  @override
  void initState() {
    context.read<TaskBloc>().add(LoadUsersEvent());
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        if (!isSearching) {
          setState(() {
            isSearching = true;
          });
        }
      }
    });
    isAdmin=widget.task.owner!.path=="users/${FirebaseAuth.instance.currentUser!.uid}";
    super.initState();
  }

  @override
  Widget build(BuildContext contextt) {
    return CustomScaffold(
      appBarTitle: "Приглашение в проект",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 4,
          ),
          searchBox(),
          isSearching
              ? const SizedBox()
              : const SizedBox(
                  height: 10,
                ),
          isSearching
              ? const SizedBox()
              : Text(
                  "Участники проекта (${widget.task.members.length})",
                  style: Styles.headerStyle,
                ),
          isSearching
              ? BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    if (state is SearchUsersState) {
                      return Expanded(
                        child: StreamBuilder(
                            stream: state.usersCollection.snapshots(),
                            builder: (context, snapshot) {
                              if ((snapshot.data?.docs) != null &&
                                  snapshot.data!.docs.isNotEmpty) {
                                return ListView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      for (var element in widget.task.members) {
                                        if (element ==
                                            snapshot.data!.docs[index]
                                                .data()
                                                .reference!
                                                .path) {
                                          return UserCard(
                                            snapshot.data!.docs[index].data(),
                                            task: widget.task,
                                            isSearching: true,
                                            isAdmin: isAdmin,
                                            isMember: true,
                                          );
                                        }
                                      }
                                      return UserCard(
                                        snapshot.data!.docs[index].data(),
                                        isSearching:true,
                                        isAdmin: isAdmin,

                                        task: widget.task,
                                      );
                                    });
                              } else {
                                return const ResultCard(
                                    "Не удалось найти пользователя",
                                    Icons.person_outline_outlined);
                              }
                            }),
                      );
                    }
                    return const Expanded(
                        child: ResultCard(
                            "Чтобы добавить участника в проект, найдите его по имени.",
                            Icons.person_add_alt_1_outlined));
                  },
                )
              : Expanded(
                  child: StreamBuilder(
                      stream: widget.task.reference!
                          .withConverter<Task>(
                            fromFirestore: (snapshots, _) =>
                                Task.fromSnapshot(snapshots),
                            toFirestore: (task, _) => task.toJson(),
                          )
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.data?.data() == null) {
                          return const CircularProgressIndicator();
                        } else {
                          if(widget.task.members.length!=snapshot.data!.data()!.members.length){
                            WidgetsBinding.instance.addPostFrameCallback((_){
                              setState(() {
                                widget.task = snapshot.data!.data()!;
                              });
                            });
                          }

                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.data()!.members.length,
                            itemBuilder: (context, index) {

                                return StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .doc(
                                        snapshot.data!.data()!.members[index])
                                        .withConverter<User>(
                                      fromFirestore: (snapshots, _) =>
                                          User.fromSnapshot(snapshots),
                                      toFirestore: (task, _) => task.toJson(),
                                    )
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.data?.data() == null) {
                                        return const SizedBox();
                                      } else {
                                        return UserCard(
                                          snapshot.data!.data()!,
                                          task: widget.task,
                                          isOwner: snapshot.data!.data()!.reference==widget.task.owner,
                                          isAdmin: isAdmin,
                                        );
                                      }
                                    });
                            },
                          );
                        }
                      }),
                )
        ],
      ),
    );
  }

  Widget searchBox() {
    return SizedBox(
        width: double.infinity,
        child: TextField(
          focusNode: focusNode,
          controller: textEditingController,
          onChanged: (text) {
            if (!isSearching) {
              isSearching = true;
              setState(() {});
            }
            if (text.length >= 3) {
              context.read<TaskBloc>().add(SearchUsersEvent(text));
            }
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            hintText: "Поиск...",
            prefixIcon: isSearching
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        textEditingController.clear();
                        focusNode.unfocus();
                        isSearching = false;
                        userSearchList.clear();
                        userSearchList.addAll(userList);
                      });
                      context.read<TaskBloc>().emit(InitState());
                    },
                    icon: const Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.black,
                    ))
                : const Icon(
                    Icons.search_outlined,
                    color: Colors.black,
                  ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ));
  }
}
