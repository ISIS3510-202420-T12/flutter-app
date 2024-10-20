import 'package:flutter/material.dart';
import 'package:wearabouts/core/repositories/clothesRepository.dart';
import 'package:wearabouts/core/repositories/model/clothe.dart';
import 'package:wearabouts/core/repositories/usersRepository.dart';

import '../../../core/repositories/model/user.dart';
import '../../auth/viewmodel/userViewModel.dart';

class MarketPlaceViewModel with ChangeNotifier {
  final ClothesRepository _clothesRepository;
  final UsersRepository _usersRepository;

  MarketPlaceViewModel(this._clothesRepository, this._usersRepository);

  List<Clothe> items = [];
  List<Clothe> kart = [];

  setItems(List<Clothe> newlist) {
    items = newlist;
    notifyListeners();
  }

  getMarketItems() {
    return items;
  }

  updateItems(List<Clothe> _items) {
    items = _items;
    notifyListeners();
  }

  Future<void> populate() async {
    try {
      List<Clothe> fetchedItems = await _clothesRepository.fetchClothes();
      setItems(fetchedItems);
      print("Market items loaded");
      notifyListeners();
    } catch (e) {
      print('Error fetching items: $e');
    }
  }

  addToKart(Clothe _item_) {
    if (!kart.contains(_item_)) {
      kart.add(_item_);
      notifyListeners();
      return "Item added to the kart";
    } else {
      return "Item already in the kart";
    }
  }

  void makePayment(BuildContext context, UserViewModel userViewModel) async {
    try {
      Set<String> allLabels = {};

      for (Clothe clothe in kart) {
        allLabels.addAll(clothe.labels);
      }

      User? currentUser = userViewModel.user;

      if (currentUser != null) {
        Set<String> updatedLabels = {...currentUser.labels, ...allLabels};

        currentUser.labels = updatedLabels.toList();
        await _usersRepository.updateUserLabels(
            currentUser.id, currentUser.labels);

        // Notificar a los listeners del UserViewModel que el usuario ha sido actualizado
        userViewModel.setUser(currentUser);
        notifyListeners();
      } else {
        print('No user is logged in.');
      }
    } catch (e) {
      print('Error updating user labels: $e');
    }
  }

  void sortItemsByUserLabels(List<String> userLabels) {
    // Ordena los items de acuerdo con las etiquetas del usuario
    items.sort((a, b) {
      // Si el item 'a' tiene una etiqueta que coincide con las del usuario, se prioriza
      bool aHasLabel = a.labels.any((label) => userLabels.contains(label));
      bool bHasLabel = b.labels.any((label) => userLabels.contains(label));

      if (aHasLabel && !bHasLabel) {
        return -1; // 'a' debe aparecer antes
      } else if (!aHasLabel && bHasLabel) {
        return 1; // 'b' debe aparecer antes
      } else {
        return 0; // De lo contrario, quedan en el mismo lugar
      }
    });

    print(
        "Items organizados"); // Notifica a los listeners que los items fueron actualizados
  }

  double obtainPrice() {
    double totalPrice = 0;
    for (var kartItem in kart) {
      totalPrice += kartItem.price;
    }

    return totalPrice;
  }
}
