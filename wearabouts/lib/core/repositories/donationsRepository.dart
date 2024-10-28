import 'model/Donation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonationsRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Donation>> fetchDonations() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection('Donations').get();

      // Utiliza un ciclo que maneja errores individuales
      List<Donation> DonationsList = [];

      for (var doc in querySnapshot.docs) {
        try {
          // Intenta cargar cada documento
          Donation donation = Donation.fromDocument(doc);
          DonationsList.add(donation);
        } catch (e) {
          // En caso de error con un documento, se captura pero no se interrumpe el ciclo
          print("Error loading document ${doc.id}: $e");
        }
      }

      return DonationsList;
    } catch (e) {
      throw Exception("Error fetching Donations: $e");
    }
  }

  Future<void> addDonation({
    required String campaignId,
    required DateTime date,
    required double quantity,
    required String userId,
  }) async {
    try {
      await _db.collection('Donations').add({
        'Campaign': _db
            .collection('Campaigns')
            .doc(campaignId), // Referencia de campaña
        'Date': Timestamp.fromDate(date), // Fecha como Timestamp
        'Quantity': quantity, // Cantidad
        'User': _db.collection('Users').doc(userId), // Referencia de usuario
      });
    } catch (e) {
      throw Exception("Error adding Donation: $e");
    }
  }
}
