import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/Activity.dart';

class ActivitiesRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Método para obtener actividades específicas de un usuario en Firestore
  Future<List<Activity>> fetchActivitiesByUser(String userId) async {
    try {
      // Referencia al documento del usuario
      DocumentReference userRef = _db.collection('Users').doc(userId);

      // Consulta a Firestore con el filtro de usuario
      QuerySnapshot querySnapshot = await _db
          .collection('Activities')
          .where('User', isEqualTo: userRef)
          .get();

      List<Activity> activitiesList = [];

      for (var doc in querySnapshot.docs) {
        try {
          Activity activity = Activity.fromDocument(doc);
          activitiesList.add(activity);
        } catch (e) {
          print("Error loading document ${doc.id}: $e");
        }
      }

      return activitiesList;
    } catch (e) {
      throw Exception("Error fetching activities: $e");
    }
  }

  /// Método para agregar una nueva actividad a Firestore
  Future<void> addActivity({
    required String event,
    required DateTime eventDate,
    required String userId,
  }) async {
    try {
      await _db.collection('Activities').add({
        'Event': event,
        'EventDate': Timestamp.fromDate(eventDate),
        'User': _db.collection('Users').doc(userId),
      });
      print("Activity added successfully.");
    } catch (e) {
      throw Exception("Error adding activity: $e");
    }
  }
}
