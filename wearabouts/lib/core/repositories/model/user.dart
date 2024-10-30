import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String id;
  String username;
  String password;
  String email;
  int sales;
  int purchases;
  String profilePic;
  int rating;
  Map<String, int> labels;
  double lattitude;
  double longitude;
  String city;

  User(
      {required this.id,
      required this.username,
      required this.password,
      required this.email,
      required this.sales,
      required this.purchases,
      required this.profilePic,
      required this.rating,
      required this.labels,
      required this.lattitude,
      required this.longitude,
      required this.city});

  // Método para crear una instancia de User a partir de un DocumentSnapshot
  factory User.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return User(
        id: doc.id,
        username: data['Username'] ?? '', // Campo 'username' del documento
        password: data['Password'] ?? '', // Campo 'password' del documento
        email: data['Email'] ?? '', // Campo 'email' del documento
        sales: data['Sales'] ?? 0, // Campo 'sales', se convierte a int
        purchases: data['Purchases'] ?? 0,
        profilePic: data['ProfilePic'] ?? '',
        rating: data['Rating'] ?? 0,
        labels: (data['Labels'] != null)
            ? Map<String, int>.from(data['Labels'])
            : {},
        longitude: data['Longitude'],
        lattitude: data['Latitude'],
        city: data['City']);
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
