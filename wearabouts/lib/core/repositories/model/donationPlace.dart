import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class DonationPlace {
  String id;
  double lattitude;
  double longitude;
  String name;
  String description;
  String image;

  DonationPlace({
    required this.id,
    required this.lattitude,
    required this.longitude,
    required this.name,
    required this.description,
    required this.image,
  });

  // Método para crear una instancia de DonationPlace a partir de un DocumentSnapshot
  factory DonationPlace.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return DonationPlace(
      id: doc.id,
      lattitude: data['Latitude'], // Campo 'lattitude' del documento
      longitude: data['Longitude'], // Campo 'longitude' del documento
      name: data['Name'] ?? '', // Campo 'name' del documento
      description:
          data['Description'] ?? '', // Campo 'description' del documento
      image: data['Image'] ?? '', // Campo 'image' del documento
      // Campo 'ong' es una referencia de documento
    );
  }
}
