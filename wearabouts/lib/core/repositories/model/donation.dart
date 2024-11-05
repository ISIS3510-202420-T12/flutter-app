import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class Donation {
  String id;
  DocumentReference campaign;
  DateTime date;
  double quantity;
  DocumentReference user;

  Donation({
    required this.id,
    required this.campaign,
    required this.date,
    required this.quantity,
    required this.user,
  });

  // Método para crear una instancia de Donation a partir de un DocumentSnapshot
  factory Donation.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Donation(
      id: doc.id,
      campaign: data['Campaign']
          as DocumentReference, // Campo 'campaign' como referencia de documento
      date: (data['Date'] as Timestamp)
          .toDate(), // Campo 'date' convertido a DateTime
      quantity: data['Quantity'] ?? 0.0,
      user: data['User'] as DocumentReference,
    );
  }
}
