import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  String id;
  String event;
  DateTime eventDate;
  DocumentReference user;

  Activity(
      {required this.id,
      required this.event,
      required this.eventDate,
      required this.user});

  // Método para crear una instancia de Activity a partir de un DocumentSnapshot
  factory Activity.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Activity(
        id: doc.id, // ID del documento
        event: data['Event'] ?? '', // Campo 'event' del documento
        eventDate: (data['EventDate'] as Timestamp).toDate(),
        user: data['User'] // Convierte Timestamp a DateTime
        );
  }
}
