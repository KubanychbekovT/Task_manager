import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:systemforschool/core/firebase/models/user.dart';
import 'package:systemforschool/utils/constants.dart';
import 'package:systemforschool/view/screens/user_projects_screen.dart';
import 'package:systemforschool/view/widgets/user_icon.dart';

import '../../core/firebase/models/task.dart';

class UserCard extends StatefulWidget {
  UserCard(this.user,
      {Key? key,
      this.task,
      this.isMember = false,
      this.isSearching = false,
      this.isOwner = false,
      this.isAdmin = false,
      this.isMemberScreen = true})
      : super(key: key);
  final Task? task;
  bool isMember;
  final bool isMemberScreen;
  final bool isAdmin;
  final bool isSearching;
  final User user;
  final bool isOwner;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          if (!widget.isMemberScreen) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserProjectsScreen(widget.user)));
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
                child: UserIcon(widget.user.name)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.user.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                if (widget.isMemberScreen && !widget.isSearching) ...[
                  Text(
                    widget.isOwner ? "Админ" : "Участник",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ]
              ],
            ),
            Expanded(child: SizedBox()),

            if (widget.isMemberScreen) ...[
              if (widget.isSearching) ...[
                if(isLoading)...[
                  const SizedBox(height:24,width:24,child: CircularProgressIndicator(color: AppConstants.secondaryColor,))
                ]else...[
                  if (widget.isMember) ...[
                    const Icon(
                      Icons.done,
                      color: Colors.green,
                    )
                  ] else ...[
                    if (widget.isAdmin) ...[
                      InkWell(
                        onTap: () {
                          setState(() {
                            isLoading=true;
                          });
                          widget.task!.reference!.update({
                            "members": FieldValue.arrayUnion(
                                [widget.user.reference!.path])
                          }).then((value) {
                            setState(() {
                              widget.isMember = true;
                              isLoading=false;
                            });
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppConstants.secondaryColor,
                                width: 2.0,
                              ),
                            ),
                            child: Icon(
                              Icons.add,
                              color: AppConstants.secondaryColor,
                              size: 16,
                            )),
                      )
                    ]
                  ]
                ]

              ] else ...[
                if (widget.isAdmin&&!widget.isOwner) ...[
                  if(isLoading)...[
                    const SizedBox(height:24,width:24,child: CircularProgressIndicator(color: Colors.red,))
                  ]
                  else...[
                    InkWell(
                      onTap: () {
                        setState(() {
                          isLoading=true;
                        });
                        widget.task!.reference!.update({
                          "members": FieldValue.arrayRemove(
                              [widget.user.reference!.path])
                        }).then((value) {
                          setState(() {
                            isLoading=false;
                          });
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.red,
                              width: 2.0,
                            ),
                          ),
                          child: Icon(
                            Icons.remove,
                            color: Colors.red,
                            size: 16,
                          )),
                    )
                  ]

                ]
              ]
            ]
          ],
        ),
      ),
    );
  }
}
