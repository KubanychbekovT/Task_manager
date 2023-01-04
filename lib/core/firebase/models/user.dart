import 'package:cloud_firestore/cloud_firestore.dart';


class User {
  String name;
  String email;
  User({
    required this.name,
    required this.email,
  });
  DocumentReference? reference;

  factory User.fromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      email:json['email'] as String,
  ) ;

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    final user = User.fromJson(snapshot.data() as Map<String, dynamic>);
    user.reference = snapshot.reference;
    return user;
  }
  Map<String,dynamic> toJson()=>{
    'name':name,
    'email':email
  };
}
