import 'model/clothe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ClothesRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Clothe>> fetchClothes() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection('Clothes').get();
      List<Clothe> clothesList = [];

      for (var doc in querySnapshot.docs) {
        try {
          Clothe clothe = Clothe.fromDocument(doc);
          clothesList.add(clothe);
        } catch (e) {
          print("Error loading document ${doc.id}: $e");
        }
      }

      return clothesList;
    } catch (e) {
      throw Exception("Error fetching clothes: $e");
    }
  }

  Future<List<Clothe>> fetchFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? favoritesJson = prefs.getString('favorites');

    if (favoritesJson != null) {
      final List decodedList = jsonDecode(favoritesJson);
      return decodedList.map((e) => Clothe.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<void> saveFavorite(Clothe clothe) async {
    List<Clothe> currentFavorites = await fetchFavorites();
    if (!currentFavorites.contains(clothe)) {
      currentFavorites.add(clothe);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String encodedList =
          jsonEncode(currentFavorites.map((e) => e.toJson()).toList());
      await prefs.setString('favorites', encodedList);
    }
  }

  Future<void> removeFavorite(String clotheId) async {
    // Obtener la lista actual de favoritos
    List<Clothe> currentFavorites = await fetchFavorites();

    // Eliminar el clothe de la lista
    currentFavorites.removeWhere((clothe) => clothe.id == clotheId);

    // Guardar la lista actualizada en SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedList =
        jsonEncode(currentFavorites.map((e) => e.toJson()).toList());
    await prefs.setString('favorites', encodedList);
  }

  Future<void> clearFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Elimina la lista de favoritos de SharedPreferences
    await prefs.remove('favorites'); // 'favorites' es la clave donde se guardan
  }
}
