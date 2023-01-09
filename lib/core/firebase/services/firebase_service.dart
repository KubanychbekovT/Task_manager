import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:systemforschool/core/firebase/models/user.dart';

import '../models/task.dart';

class FirebaseService {
  Query<Task> getStreamTasks() {
    return FirebaseFirestore.instance
        .collection('tasks')
        .where("members",
            arrayContains: "users/${FirebaseAuth.instance.currentUser!.uid}")
        .withConverter<Task>(
          fromFirestore: (snapshots, _) => Task.fromSnapshot(snapshots),
          toFirestore: (task, _) => task.toJson(),
        );
  }

  Query<User> getStreamUsers() {
    return FirebaseFirestore.instance
        .collection('users')
        .where("email", isNotEqualTo: FirebaseAuth.instance.currentUser!.email)
        .withConverter<User>(
          fromFirestore: (snapshots, _) => User.fromSnapshot(snapshots),
          toFirestore: (task, _) => task.toJson(),
        );
  }

  Query<User> getStreamSearchedUsers(String query) {
    var searchedUsers = FirebaseFirestore.instance
        .collection('users')
        .where("nameSearch", arrayContains: query.toLowerCase())
        .withConverter<User>(
          fromFirestore: (snapshots, _) => User.fromSnapshot(snapshots),
          toFirestore: (task, _) => task.toJson(),
        );
    return searchedUsers;
  }

  Query<Task> getStreamOwnerTasks(
      DocumentReference<Object?>? documentReference) {
    return FirebaseFirestore.instance
        .collection("tasks")
        .where("owner", isEqualTo: documentReference)
        .where("isPublic", isEqualTo: true)
        .withConverter<Task>(
          fromFirestore: (snapshots, _) => Task.fromSnapshot(snapshots),
          toFirestore: (task, _) => task.toJson(),
        );
  }
}
