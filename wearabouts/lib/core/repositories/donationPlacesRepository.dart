import 'model/donationPlace.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonationPlacesRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<DonationPlace>> fetchDonationPlaces() async {
    try {
      QuerySnapshot querySnapshot =
          await _db.collection('DonationPlaces').get();

      // Utiliza un ciclo que maneja errores individuales
      List<DonationPlace> donationPlacesList = [];

      for (var doc in querySnapshot.docs) {
        try {
          // Intenta cargar cada documento
          DonationPlace donationPlace = DonationPlace.fromDocument(doc);
          donationPlacesList.add(donationPlace);
        } catch (e) {
          // En caso de error con un documento, se captura pero no se interrumpe el ciclo
          print("Error loading document ${doc.id}: $e");
        }
      }

      return donationPlacesList;
    } catch (e) {
      throw Exception("Error fetching donation places: $e");
    }
  }
}
