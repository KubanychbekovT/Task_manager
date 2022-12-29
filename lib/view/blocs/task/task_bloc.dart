import 'package:bloc/bloc.dart';
import 'package:systemforschool/repo/tasks_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/firebase/models/task.dart';
part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TasksRepoImp _repoImp = TasksRepoImp();


  TaskBloc() : super(InitState()) {
    on<LoadTasksEvent>(_loadTask);
  }
  _loadTask(LoadTasksEvent event, Emitter<TaskState> emitter) async {
   // QuerySnapshot<Map> a=await  FirebaseFirestore.instance.collection("tasks").get();
   // for (QueryDocumentSnapshot element in a.docs) {
   //   print(element["name"]);
   //   print(element.data());
   // }
   //  var b=FirebaseFirestore.instance
   //      .collection('tasks').withConverter<Task>(
   //  fromFirestore: (snapshots, _) => Task.fromSnapshot(snapshots),
   //  toFirestore: (task, _) => task.toJson(),
   //  );
    //print((await b.get()).docs.first.data().name);
    // await (FirebaseFirestore.instance.collection("tasks").get()).then((value) => value.docs.forEach((element) {
    //   print(element["name"]);
    // }));
     emitter(TasksStreamLoaded(_repoImp.getStreamTasks()));

  }
}
