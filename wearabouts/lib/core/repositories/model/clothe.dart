import 'package:cloud_firestore/cloud_firestore.dart';

class Clothe {
  String id;
  DocumentReference seller;
  String description; // Ya no es 'late'
  String title; // Ya no es 'late'
  int price;
  int rating;
  String size;
  List<String> imagesURLs; // Ya no es 'late'
  List<String> labels; // Ya no es 'late'

  Clothe({
    required this.id,
    required this.seller,
    required this.description,
    required this.title,
    required this.price,
    required this.rating,
    required this.size,
    required this.imagesURLs,
    required this.labels,
  });

  // Método para crear una instancia de Clothe a partir de un DocumentSnapshot
  factory Clothe.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Clothe(
      id: doc.id,
      title: data['Title'] ?? '', // Campo 'title' del documento
      description:
          data['Description'] ?? '', // Campo 'description' del documento
      size: data['Size'] ?? 'Unknown', // Campo 'size' del documento
      price: data['Price'] ?? 0, // Campo 'price', se convierte a int
      rating: data['Rating'], // Campo 'rating', se convierte a int
      seller: data['Seller'], // Campo 'seller'
      imagesURLs: List<String>.from(data['ImagesURLs'] ?? []), // Lista de URLs
      labels: List<String>.from(data['Labels'] ?? []), // Lista de etiquetas
    );
  }
}
