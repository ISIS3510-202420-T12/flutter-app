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
    // Verifica si el clothe ya está en la lista de favoritos
    bool isAlreadyFavorite = items.any((favorite) => favorite.id == clothe.id);

    if (!isAlreadyFavorite) {
      await _clothesRepository.saveFavorite(clothe);
      await populate(); // Vuelve a cargar los favoritos para reflejar cambios
    } else {
      print("El clothe ya está en la lista de favoritos.");
    }
  }

  // Método para eliminar un favorito por ID
  void deleteFromFavorites(String clotheId) {
    items.removeWhere((item) => item.id == clotheId);
    _clothesRepository.clearFavorites();
    notifyListeners();
  }

  // Método para limpiar todos los favoritos
  Future<void> clearFavorites() async {
    items.clear();
    await _clothesRepository.clearFavorites();
    notifyListeners();
  }

  // Verificar si un artículo es favorito
  bool isFavorite(String clotheId) {
    return items.any((item) => item.id == clotheId);
  }
}
