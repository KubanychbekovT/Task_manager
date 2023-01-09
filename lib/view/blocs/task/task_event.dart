part of 'task_bloc.dart';

abstract class TaskEvent {
  const TaskEvent();
}

class InitEvent extends TaskEvent {}

class LoadTasksEvent extends TaskEvent {
}
class ChangeFilterEvent extends TaskEvent{
  int category;
  ChangeFilterEvent({this.category=1});

}
class LoadUsersEvent extends TaskEvent {}

class SearchUsersEvent extends TaskEvent {
  final String query;

  SearchUsersEvent(this.query);
}

class LoadOwnerTasksEvent extends TaskEvent {
  final DocumentReference<Object?>? documentReference;

  LoadOwnerTasksEvent(this.documentReference);
}
class ProjectEditingStartedEvent extends TaskEvent{}
class ProjectEditingFinishedEvent extends TaskEvent{}

class TaskEditingStartedEvent extends TaskEvent {}
class TaskEditingFinishedEvent extends TaskEvent {}

