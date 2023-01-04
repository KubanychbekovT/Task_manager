import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:systemforschool/core/firebase/models/user.dart';
import 'package:systemforschool/view/screens/user_projects_screen.dart';
class UserCard extends StatelessWidget {
  const UserCard(this.user,{Key? key}) : super(key: key);
  final User user;
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserProjectsScreen(user)));

          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10,top: 5,bottom: 5),
                child: CircleAvatar(
                  radius: 20.0,
                  child: SvgPicture.asset(
                    "assets/images/user.svg",
                    height: 15,
                    width: 15,
                  )
                  ,
                  backgroundColor: Colors.grey[300],
                ),
              ),
              Container(
                child: Text(
                  user.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),


            ],
          ),
        ),
      );
    }
  }
