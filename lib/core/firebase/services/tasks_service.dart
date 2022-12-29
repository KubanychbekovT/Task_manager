import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class FirebaseService {
  final CollectionReference<Task> tasks =  FirebaseFirestore.instance
      .collection('tasks')
      .withConverter<Task>(
    fromFirestore: (snapshots, _) => Task.fromSnapshot(snapshots),
    toFirestore: (task, _) => task.toJson(),
  );

  CollectionReference<Task> getStreamTasks(){
     return tasks;
  }


}
