import 'package:flutter/material.dart';
import 'package:wearabouts/features/home/model/clothe.dart';

class FavoritesViewModel with ChangeNotifier {
  List<Clothe> items = [];

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

  populate() {
    for (int i = 0; i <= 10; i++) {
      items.add(Clothe());
    }
    notifyListeners();
  }
}
