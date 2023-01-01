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
    on<EditingStartedEvent>(_editingStarted);
  }
  _editingStarted(EditingStartedEvent event, Emitter<TaskState> emitter) async {
    emitter(EditingStartedState());

  }
  _loadTask(LoadTasksEvent event, Emitter<TaskState> emitter) async {

     emitter(TasksStreamLoaded(_repoImp.getStreamTasks()));

  }
}
