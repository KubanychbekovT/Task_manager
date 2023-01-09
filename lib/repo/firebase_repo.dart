import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:systemforschool/core/firebase/models/task.dart';
import 'package:systemforschool/core/firebase/models/user.dart';
import 'package:systemforschool/core/firebase/services/firebase_service.dart';

class FirebaseRepoImp {
  final FirebaseService _firebaseService = FirebaseService();
  Query<Task> getStreamTasks(){
    return _firebaseService.getStreamTasks();
  }
  Query<Task> getStreamOwnerTasks(DocumentReference<Object?>? documentReference){
    return _firebaseService.getStreamOwnerTasks(documentReference);
  }

  Query<User> getStreamUsers(){
    return _firebaseService.getStreamUsers();
  }
  Query<User> getStreamSearchedUsers(String query){
    return _firebaseService.getStreamSearchedUsers(query);
  }
}


