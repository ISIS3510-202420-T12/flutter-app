import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/clothe.dart';

class ClothesRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Clothe>> fetchClothes() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection('Clothes').get();
      return querySnapshot.docs.map((doc) {
        return Clothe.fromDocument(doc);
      }).toList();
    } catch (e) {
      throw Exception("Error fetching clothes: $e");
    }
  }
}
