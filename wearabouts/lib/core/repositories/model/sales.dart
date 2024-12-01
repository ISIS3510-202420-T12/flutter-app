import 'package:cloud_firestore/cloud_firestore.dart';

class Sales {
  String id;
  DateTime date;
  DocumentReference user; // Referencia al usuario
  double price;
  DocumentReference item; // Referencia al ítem (Clothe)

  Sales({
    required this.id,
    required this.date,
    required this.user,
    required this.price,
    required this.item,
  });

  // Método para crear una instancia de Sales a partir de un DocumentSnapshot
  factory Sales.fromDocument(DocumentSnapshot doc) {
    try {
      final data = doc.data() as Map<String, dynamic>;

      // Verifica que los campos críticos estén presentes y sean válidos
      if (data['Date'] == null || data['Date'] is! Timestamp) {
        throw Exception("Invalid or missing 'Date' in document ${doc.id}");
      }
      if (data['User'] == null || data['User'] is! DocumentReference) {
        throw Exception("Invalid or missing 'User' in document ${doc.id}");
      }
      if (data['Price'] == null ||
          (data['Price'] is! int && data['Price'] is! double)) {
        throw Exception("Invalid or missing 'Price' in document ${doc.id}");
      }
      if (data['Item'] == null || data['Item'] is! DocumentReference) {
        throw Exception("Invalid or missing 'Item' in document ${doc.id}");
      }

      // Convertir 'Price' a double si es int
      double price = (data['Price'] is int)
          ? (data['Price'] as int).toDouble()
          : data['Price'];

      return Sales(
        id: doc.id,
        date: (data['Date'] as Timestamp).toDate(),
        user: data['User'],
        price: price,
        item: data['Item'],
      );
    } catch (e) {
      throw Exception("Error parsing document ${doc.id}: $e");
    }
  }

  // Serializa el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': Timestamp.fromDate(date),
      'user': user.path,
      'price': price,
      'item': item.path,
    };
  }

  // Deserializa un JSON a una instancia de Sales
  factory Sales.fromJson(Map<String, dynamic> json) {
    DocumentReference userRef = FirebaseFirestore.instance.doc(json['user']);
    DocumentReference itemRef = FirebaseFirestore.instance.doc(json['item']);
    return Sales(
      id: json['id'],
      date: (json['date'] as Timestamp).toDate(),
      user: userRef,
      price: json['price'],
      item: itemRef,
    );
  }
}
