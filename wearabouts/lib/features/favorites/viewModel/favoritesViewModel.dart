import 'package:flutter/material.dart';
import 'package:wearabouts/core/repositories/model/clothe.dart';

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
    notifyListeners();
  }
}
