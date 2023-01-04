import 'package:bloc/bloc.dart';
import 'package:systemforschool/core/firebase/models/user.dart';
import 'package:systemforschool/repo/firebase_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/firebase/models/task.dart';
part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final FirebaseRepoImp _repoImp = FirebaseRepoImp();


  TaskBloc() : super(InitState()) {
    on<LoadUsersEvent>(_loadUser);
    on<LoadTasksEvent>(_loadTask);
    on<EditingStartedEvent>(_editingStarted);
    on<LoadOwnerTasksEvent>(_loadOwnerTasks);
  }
  _loadOwnerTasks(LoadOwnerTasksEvent event,Emitter<TaskState> emitter)async{
    var querySnapshot =  FirebaseFirestore.instance.collection("tasks").where("owner",isEqualTo:event.documentReference).withConverter<Task>(
      fromFirestore: (snapshots, _) => Task.fromSnapshot(snapshots),
      toFirestore: (task, _) => task.toJson(),
    );
    emitter(LoadOwnerTasksState(querySnapshot));
  }
  _loadUser(LoadUsersEvent event,Emitter<TaskState> emitter){
    emitter(UsersStreamLoaded(_repoImp.getStreamUsers()));
  }
  _editingStarted(EditingStartedEvent event, Emitter<TaskState> emitter) async {
    emitter(EditingStartedState());

  }
  _loadTask(LoadTasksEvent event, Emitter<TaskState> emitter) async {
     emitter(TasksStreamLoaded(_repoImp.getStreamTasks()));
  }
}
