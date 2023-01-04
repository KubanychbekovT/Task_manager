part of 'task_bloc.dart';
abstract class TaskEvent {
  const TaskEvent();
}

class InitEvent extends TaskEvent {}

class LoadTasksEvent extends TaskEvent {}
class LoadUsersEvent extends TaskEvent {}
class LoadOwnerTasksEvent extends TaskEvent {
  final DocumentReference<Object?>? documentReference;
  LoadOwnerTasksEvent(this.documentReference);
}
class EditingStartedEvent extends TaskEvent {}
