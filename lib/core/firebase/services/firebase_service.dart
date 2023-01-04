import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:systemforschool/core/firebase/models/user.dart';
import '../models/task.dart';

class FirebaseService {
  final Query<Task> tasks =  FirebaseFirestore.instance
      .collection('tasks').where("owner",isEqualTo:FirebaseFirestore.instance.doc("users/${FirebaseAuth.instance.currentUser!.uid}"))
      .withConverter<Task>(
    fromFirestore: (snapshots, _) => Task.fromSnapshot(snapshots),
    toFirestore: (task, _) => task.toJson(),
  );

  Query<Task> getStreamTasks(){
     return tasks;
  }
  final Query<User> users =  FirebaseFirestore.instance
      .collection('users').where("email",isNotEqualTo: FirebaseAuth.instance.currentUser!.email)
      .withConverter<User>(
    fromFirestore: (snapshots, _) => User.fromSnapshot(snapshots),
    toFirestore: (task, _) => task.toJson(),
  );
  Query<User> getStreamUsers(){
    return users;
  }

}
