part of 'task_bloc.dart';
abstract class TaskEvent {
  const TaskEvent();
}

class InitEvent extends TaskEvent {}

class LoadTasksEvent extends TaskEvent {}
