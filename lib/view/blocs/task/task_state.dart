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
class TasksStreamLoaded extends TaskState {
  CollectionReference<Task> tasksCollection;
  TasksStreamLoaded(this.tasksCollection);
}

