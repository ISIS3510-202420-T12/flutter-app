import 'package:flutter/material.dart';
import 'package:wearabouts/core/repositories/clothesRepository.dart';
import 'package:wearabouts/core/repositories/model/clothe.dart';

class MarketPlaceViewModel with ChangeNotifier {
  final ClothesRepository _clothesRepository;

  MarketPlaceViewModel(this._clothesRepository);

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
      notifyListeners();
    } catch (e) {
      print('Error fetching items: $e');
    }
  }

  addToKart(Clothe _item_) {
    kart.add(_item_);
    notifyListeners();
  }

  void makePayment(BuildContext context) {}
}
