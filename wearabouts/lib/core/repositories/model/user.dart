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
  bool hasDonated;

  User({
    this.id = '',
    required this.username,
    required this.password,
    required this.email,
    this.sales = 0,
    this.purchases = 0,
    this.profilePic = '',
    this.rating = 5,
    Map<String, int>? labels,
    required this.latitude,
    required this.longitude,
    required this.city,
    this.hasDonated = false,
  }) : labels = labels ??
            {
              'footwear': 0,
              'leather': 0,
              'outerwear': 0,
              'rainy day': 0,
              'shoes': 0,
              'sports': 0,
              't-shirts': 0,
              'tops': 0,
            };

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
      rating: data['Rating'] ?? 5,
      labels:
          (data['Labels'] != null) ? Map<String, int>.from(data['Labels']) : {},
      latitude: data['Latitude'] ?? 0.0,
      longitude: data['Longitude'] ?? 0.0,
      city: data['City'] ?? '',
      hasDonated: data['HasDonated'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Username': username,
      'Password': password,
      'Email': email,
      'Sales': sales,
      'Purchases': purchases,
      'ProfilePic': profilePic,
      'Rating': rating,
      'Labels': labels,
      'Latitude': latitude,
      'Longitude': longitude,
      'City': city,
      'HasDonated': hasDonated,
    };
  }
}
