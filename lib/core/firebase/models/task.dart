import 'package:cloud_firestore/cloud_firestore.dart';

import 'task_item.dart';

class Task {
  String name;
  List<TaskItem> tasks;
  Task({
    required this.name,
    required this.tasks,
    required this.owner
  });
  DocumentReference? owner;
  DocumentReference? reference;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
      name: json['name'] as String,
      owner:json['owner'] as DocumentReference<Object>,
      tasks: (json['tasks'] == null ? <TaskItem>[]: json['tasks'] as List<dynamic>).map((e) => TaskItem.fromJson(e)).toList()

  ) ;

  factory Task.fromSnapshot(DocumentSnapshot snapshot) {
    final task = Task.fromJson(snapshot.data() as Map<String, dynamic>);
    task.reference = snapshot.reference;
    return task;
  }
  Map<String,dynamic> toJson()=>{
    'name':name,
    'tasks':tasks
  };
}
