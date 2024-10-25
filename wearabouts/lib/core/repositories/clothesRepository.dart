import 'model/clothe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClothesRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Clothe>> fetchClothes() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection('Clothes').get();

      // Utiliza un ciclo que maneja errores individuales
      List<Clothe> clothesList = [];

      for (var doc in querySnapshot.docs) {
        try {
          // Intenta cargar cada documento
          Clothe clothe = Clothe.fromDocument(doc);
          clothesList.add(clothe);
        } catch (e) {
          // En caso de error con un documento, se captura pero no se interrumpe el ciclo
          print("Error loading document ${doc.id}: $e");
        }
      }

      return clothesList;
    } catch (e) {
      throw Exception("Error fetching clothes: $e");
    }
  }
}
