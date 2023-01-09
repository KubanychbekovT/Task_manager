import 'package:cloud_firestore/cloud_firestore.dart';

class TaskItem {
  bool complete;
  String itemName;
  Timestamp creationDate;
  String owner;
  TaskItem({required this.itemName,required this.creationDate,required this.owner,required this.complete});
  factory TaskItem.fromJson(Map<String, dynamic> json) =>
      TaskItem(itemName: json['itemName'] as String,owner:json['owner']as String, creationDate: json['date'] as Timestamp,complete: json['complete']);
}
