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
    on<ChangeFilterEvent>(_changeFilterEvent);
    on<SearchUsersEvent>(_searchUsers);
    on<LoadTasksEvent>(_loadTask);
    on<LoadOwnerTasksEvent>(_loadOwnerTasks);
    on<TaskEditingStartedEvent>((event,emit)=>emit(TaskEditingStartedState()));
    on<ProjectEditingStartedEvent>((event,emit)=>emit(ProjectEditingStartedState()));
    on<TaskEditingFinishedEvent>((event,emit)=>emit(TaskEditingFinishedState()));
    on<ProjectEditingFinishedEvent>((event,emit)=>emit(ProjectEditingFinishedState()));
  }
  _changeFilterEvent(ChangeFilterEvent event,Emitter<TaskState> emitter){
    emitter(ChangeFilterState(event.category));
  }
  _searchUsers(SearchUsersEvent event,Emitter<TaskState> emitter)async{
    emitter(SearchUsersState(_repoImp.getStreamSearchedUsers(event.query)));
  }
  _loadOwnerTasks(LoadOwnerTasksEvent event,Emitter<TaskState> emitter)async{
    emitter(LoadOwnerTasksState(_repoImp.getStreamOwnerTasks(event.documentReference)));
  }
  _loadUser(LoadUsersEvent event,Emitter<TaskState> emitter){
    emitter(UsersStreamLoaded(_repoImp.getStreamUsers()));
  }
  _loadTask(LoadTasksEvent event, Emitter<TaskState> emitter) async {
     emitter(TasksStreamLoaded(_repoImp.getStreamTasks()));
  }
}
