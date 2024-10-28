import 'model/Campaign.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CampaignsRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Campaign>> fetchCampaigns() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection('Campaigns').get();

      // Utiliza un ciclo que maneja errores individuales
      List<Campaign> CampaignsList = [];

      for (var doc in querySnapshot.docs) {
        try {
          // Intenta cargar cada documento
          Campaign campaign = Campaign.fromDocument(doc);
          CampaignsList.add(campaign);
        } catch (e) {
          // En caso de error con un documento, se captura pero no se interrumpe el ciclo
          print("Error loading document ${doc.id}: $e");
        }
      }

      return CampaignsList;
    } catch (e) {
      throw Exception("Error fetching Campaigns: $e");
    }
  }
}
