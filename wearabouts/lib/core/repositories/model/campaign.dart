import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class Campaign {
  String id;
  double goal;
  String image;
  String name;

  double reached;

  Campaign({
    required this.id,
    required this.goal,
    required this.image,
    required this.name,
    required this.reached,
  });

  // Método para crear una instancia de Campaign a partir de un DocumentSnapshot
  factory Campaign.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Campaign(
      id: doc.id,
      goal: (data['Goal'] is int
          ? (data['Goal'] as int).toDouble()
          : data['Goal'] ?? 0.0),
      image: data['Image'] ?? '',
      name: data['Name'] ?? '',
      reached: (data['Reached'] is int
          ? (data['Reached'] as int).toDouble()
          : data['Reached'] ?? 0.0),
    );
  }
}
