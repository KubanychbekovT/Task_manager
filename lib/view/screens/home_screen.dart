import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:systemforschool/core/firebase/models/user.dart';
import 'package:systemforschool/utils/styles.dart';
import 'package:systemforschool/view/widgets/custom_scaffold.dart';
import 'package:systemforschool/view/widgets/user_card.dart';

import '../blocs/task/task_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<QueryDocumentSnapshot<User>> userList = [];
  List<QueryDocumentSnapshot<User>> userSearchList = [];

  @override
  Widget build(BuildContext contextt) {
    return CustomScaffold(
      appBarTitle: "Главная",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 4,
          ),
          SizedBox(
            width: double.infinity,
            child: TextField(
              onChanged: (text) {
                filterSearchResults(text);
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                hintText: "Поиск...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is UsersStreamLoaded) {
                state.usersCollection.snapshots().listen((event) {
                  print(event.docs.first.data().name);
                  userList = event.docs;
                  userSearchList = event.docs;
                });
              }
            },
            child: userSearchList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_tree_outlined,
                          size: 128,
                          color: Colors.grey,
                        ),
                        Text(
                          "Нет пользователей",
                          style: Styles.bodyStyle,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: userSearchList.length,
                        itemBuilder: (context, index) {
                          return UserCard(userSearchList[index].data());
                        }),
                  ),
          )
        ],
      ),
    );
  }

  void filterSearchResults(String query) {
    List<QueryDocumentSnapshot<User>> dummySearchList = [];
    if (query.isNotEmpty) {
      for (var item in userList) {
        if (item.data().name.toUpperCase().contains(query.toUpperCase())) {
          dummySearchList.add(item);
        }
      }
      setState(() {
        userSearchList.clear();
        userSearchList.addAll(dummySearchList);
      });
      return;
    } else {
      setState(() {
        userSearchList.clear();
        userSearchList.addAll(userList);
      });
    }
  }
}
