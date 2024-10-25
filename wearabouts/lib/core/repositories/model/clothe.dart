import 'package:cloud_firestore/cloud_firestore.dart';

class Clothe {
  String id;
  DocumentReference seller;
  String description; // Ya no es 'late'
  String title; // Ya no es 'late'
  double price;
  double rating;
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
    try {
      final data = doc.data() as Map<String, dynamic>;

      // Verifica que los campos críticos estén presentes y sean válidos
      if (data['Title'] == null || data['Title'] is! String) {
        throw Exception("Invalid or missing 'Title' in document ${doc.id}");
      }
      if (data['Price'] == null ||
          (data['Price'] is! int && data['Price'] is! double)) {
        throw Exception("Invalid or missing 'Price' in document ${doc.id}");
      }
      if (data['Seller'] == null || data['Seller'] is! DocumentReference) {
        throw Exception("Invalid or missing 'Seller' in document ${doc.id}");
      }
      if (data['ImagesURLs'] == null || data['ImagesURLs'] is! List) {
        throw Exception(
            "Invalid or missing 'ImagesURLs' in document ${doc.id}");
      }
      if (data['Labels'] == null || data['Labels'] is! List) {
        throw Exception("Invalid or missing 'Labels' in document ${doc.id}");
      }

      // Convertir 'Price' a double si es int
      double price = (data['Price'] is int)
          ? (data['Price'] as int).toDouble()
          : data['Price'];

      // Convertir 'Rating' a double si es int
      double rating = (data['Rating'] is int)
          ? (data['Rating'] as int).toDouble()
          : data['Rating'];

      return Clothe(
        id: doc.id,
        title: data['Title'] ?? '',
        description: data['Description'] ?? '',
        size: data['Size'] ?? 'Unknown',
        price: price, // Precio convertido
        rating: rating, // Rating convertido
        seller: data['Seller'], // Asumiendo que es un DocumentReference
        imagesURLs: List<String>.from(data['ImagesURLs'] ?? []),
        labels: List<String>.from(data['Labels'] ?? []),
      );
    } catch (e) {
      // Captura cualquier excepción y lanza una nueva con un mensaje detallado
      throw Exception("Error parsing document ${doc.id}: $e");
    }
  }
}
