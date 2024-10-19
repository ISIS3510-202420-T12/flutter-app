import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User();

  factory User.fromDocument(DocumentSnapshot doc) {
    return User();
  }
}
