part of 'task_bloc.dart';


abstract class TaskState {
  const TaskState();
}

class InitState extends TaskState {}

class TasksLoaded extends TaskState {
  List<Task> tasks;
  TasksLoaded(this.tasks);
}
class EditingStartedState extends TaskState{}
class LoadOwnerTasksState extends TaskState{
  Query<Task> tasksCollection;
  LoadOwnerTasksState(this.tasksCollection);
}
class TasksStreamLoaded extends TaskState {
  Query<Task> tasksCollection;
  TasksStreamLoaded(this.tasksCollection);
}
class UsersStreamLoaded extends TaskState {
  Query<User> usersCollection;
  UsersStreamLoaded(this.usersCollection);
}
