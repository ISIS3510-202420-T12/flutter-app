import 'package:flutter/material.dart';
import 'package:wearabouts/core/repositories/model/clothe.dart';
import 'package:wearabouts/core/repositories/clothesRepository.dart';

class FavoritesViewModel with ChangeNotifier {
  final ClothesRepository _clothesRepository;
  List<Clothe> items = [];

  FavoritesViewModel(this._clothesRepository);

  // Método para cargar los favoritos desde el repositorio
  Future<void> populate() async {
    items = await _clothesRepository.fetchFavorites();
    notifyListeners();
  }

  // Método para añadir un favorito a través del repositorio
  Future<void> addFavorite(Clothe clothe) async {
    // Obtén la lista actual de favoritos

    // Verifica si el clothe ya está en la lista de favoritos
    bool isAlreadyFavorite = items.any((favorite) => favorite.id == clothe.id);

    if (!isAlreadyFavorite) {
      await _clothesRepository.saveFavorite(clothe);
      await populate(); // Vuelve a cargar los favoritos para reflejar cambios
    } else {
      print("El clothe ya está en la lista de favoritos.");
    }
  }

  Future<void> clearFavorites() async {
    // Limpia la lista de favoritos en memoria
    items.clear();

    // Limpia los favoritos en SharedPreferences
    await _clothesRepository.clearFavorites();

    // Notifica a los listeners sobre el cambio
    notifyListeners();
  }

  void deleteFromFavorites(String clotheId) {
    items.removeWhere((item) => item.id == clotheId);
    notifyListeners();
  }

  bool isFavorite(String clotheId) {
    return items.any((item) => item.id == clotheId);
  }
}
