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
  double latitude;
  double longitude;
  String city;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.sales,
    required this.purchases,
    required this.profilePic,
    required this.rating,
    required this.labels,
    required this.latitude,
    required this.longitude,
    required this.city,
  });

  // Método para crear una instancia de User a partir de un DocumentSnapshot
  factory User.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return User(
      id: doc.id,
      username: data['Username'] ?? '',
      password: data['Password'] ?? '',
      email: data['Email'] ?? '',
      sales: data['Sales'] ?? 0,
      purchases: data['Purchases'] ?? 0,
      profilePic: data['ProfilePic'] ?? '',
      rating: data['Rating'] ?? 0,
      labels: (data['Labels'] != null) ? Map<String, int>.from(data['Labels']) : {},
      longitude: data['Longitude'] ?? 0.0,
      latitude: data['Latitude'] ?? 0.0,
      city: data['City'] ?? '',
    );
  }

  // Serialización JSON para usar con json_annotation
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
