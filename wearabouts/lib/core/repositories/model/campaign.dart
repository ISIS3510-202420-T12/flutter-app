import 'package:cloud_firestore/cloud_firestore.dart';

class Campaign {
  String id;
  int goal;
  String image;
  String name;
  DocumentReference ong;
  int reached;

  Campaign({
    required this.id,
    required this.goal,
    required this.image,
    required this.name,
    required this.ong,
    required this.reached,
  });

  // Método para crear una instancia de Campaign a partir de un DocumentSnapshot
  factory Campaign.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Campaign(
      id: doc.id,
      goal: data['Goal'] ?? 0, // Campo 'goal', se convierte a int
      image: data['Image'] ?? '', // Campo 'image'
      name: data['Name'] ?? '', // Campo 'name'
      ong: data['Ong']
          as DocumentReference, // Campo 'ong' como referencia de documento
      reached: data['Reached'] ?? 0, // Campo 'reached', se convierte a int
    );
  }
}
