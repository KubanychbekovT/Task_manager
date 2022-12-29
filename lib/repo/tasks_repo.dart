import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:systemforschool/core/firebase/models/task.dart';
import 'package:systemforschool/core/firebase/services/tasks_service.dart';

class TasksRepoImp implements TasksRepo {
  FirebaseService _firebaseService = FirebaseService();
  CollectionReference<Task> getStreamTasks(){
    return _firebaseService.getStreamTasks();
  }
}

abstract class TasksRepo {
  CollectionReference<Task> getStreamTasks();
}
