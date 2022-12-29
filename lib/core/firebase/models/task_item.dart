import 'package:cloud_firestore/cloud_firestore.dart';

class TaskItem {
  bool complete = false;
  String itemName;
  DocumentReference? owner;
  TaskItem({required this.itemName});
  factory TaskItem.fromJson(Map<String, dynamic> json) =>
      TaskItem(itemName: json['itemName'] as String);
}
