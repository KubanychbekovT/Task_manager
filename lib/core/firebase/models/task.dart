import 'package:cloud_firestore/cloud_firestore.dart';

import 'task_item.dart';

class Task {
  String name;
  List<TaskItem> tasks;
  Task({
    required this.name,
    required this.tasks,
    required this.owner,
    required this.members,
    required this.isPublic,
    required this.creationDate,
  });
  bool isPublic;
  Timestamp creationDate;
  List<dynamic> members;
  DocumentReference? owner;
  late DocumentReference<Task> reference;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        name: json['name'] as String,
        isPublic: json['isPublic'] as bool,
        owner: json['owner'] as DocumentReference<Object>,
        tasks: (json['tasks'] == null
                ? <TaskItem>[]
                : json['tasks'] as List<dynamic>)
            .map((e) => TaskItem.fromJson(e))
            .toList(),
        members:
            (json['members'] != null ? json['members'] as List<dynamic> : []),
        creationDate: json['date'] as Timestamp,
      );

  factory Task.fromSnapshot(DocumentSnapshot snapshot) {
    final task = Task.fromJson(snapshot.data() as Map<String, dynamic>);
    task.reference = snapshot.reference.withConverter<Task>(
        fromFirestore: (snapshots, _) => Task.fromSnapshot(snapshots),
        toFirestore: (task, _) => task.toJson());
    return task;
  }

  Map<String, dynamic> toJson() => {'name': name, 'tasks': tasks};
}
