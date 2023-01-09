part of 'task_bloc.dart';


abstract class TaskState {
  const TaskState();
}

class InitState extends TaskState {}
class SearchUsersState extends TaskState{
  final Query<User> usersCollection;

  SearchUsersState(this.usersCollection);
}
class TasksLoaded extends TaskState {
  List<Task> tasks;
  TasksLoaded(this.tasks);
}
class ProjectEditingFinishedState extends TaskState{}
class TaskEditingStartedState extends TaskState{}
class ProjectEditingStartedState extends TaskState{}
class TaskEditingFinishedState extends TaskState{}
class LoadOwnerTasksState extends TaskState{
  Query<Task> tasksCollection;
  LoadOwnerTasksState(this.tasksCollection);
}
class ChangeFilterState extends TaskState{
  final int category;
  ChangeFilterState(this.category);
}
class TasksStreamLoaded extends TaskState {
  final Query<Task> tasksCollection;
  TasksStreamLoaded(this.tasksCollection);
}
class UsersStreamLoaded extends TaskState {
  Query<User> usersCollection;
  UsersStreamLoaded(this.usersCollection);
}
