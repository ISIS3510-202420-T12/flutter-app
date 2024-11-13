import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wearabouts/core/repositories/clothesRepository.dart';
import 'package:wearabouts/core/repositories/model/clothe.dart';
import 'package:wearabouts/core/repositories/usersRepository.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:wearabouts/services/localNotifications/notificacionService.dart';
import '../../../core/repositories/model/user.dart';
import '../../auth/viewmodel/userViewModel.dart';

class MarketPlaceViewModel with ChangeNotifier {
  final ClothesRepository _clothesRepository;
  final UsersRepository _usersRepository;

  MarketPlaceViewModel(this._clothesRepository, this._usersRepository);

  List<Clothe> items = [];
  List<Clothe> kart = [];
  List<Clothe> filteredItems = [];
  Set<String> selectedCategories = {};

  List<Clothe> featured = [];
  double totalPrice = 0;
  double deliveryfee = 3000;

  setItems(List<Clothe> newlist) {
    items = newlist;
    notifyListeners();
  }

  getMarketItems() {
    return items;
  }

  updateItems(List<Clothe> _items) {
    items = _items;
    updateFilteredItems();
    notifyListeners();
  }

  void updateFilteredItems() {
    if (selectedCategories.isEmpty) {
      filteredItems = List.from(items);
    } else {
      filteredItems = items.where((item) {
        return item.labels.any((label) => selectedCategories
            .contains(label.toLowerCase())); // Convertir label a minúsculas
      }).toList();
    }
    notifyListeners();
  }

// Asegurarse de que las categorías seleccionadas estén en minúsculas
  void toggleCategory(String category) {
    String lowerCategory = category.toLowerCase();
    if (selectedCategories.contains(lowerCategory)) {
      selectedCategories.remove(lowerCategory);
    } else {
      selectedCategories.add(lowerCategory);
    }
    updateFilteredItems();
  }

  Future<void> populate(UserViewModel userViewModel) async {
    try {
      List<Clothe> fetchedItems = await _clothesRepository.fetchClothes();
      setItems(fetchedItems);
      updateFeaturedList(userViewModel.user?.labels ?? {});
      print("Market items loaded");
    } catch (e) {
      print('Error fetching items: $e');
    }
  }

  addToKart(Clothe _item_) {
    if (!kart.contains(_item_)) {
      kart.add(_item_);
      obtainPrice();
      notifyListeners();
      return "Item added to the kart";
    } else {
      return "Item already in the kart";
    }
  }

  void makePayment(BuildContext context, UserViewModel userViewModel,
      FirebaseAnalytics analytics) async {
    try {
      Map<String, int> allLabels = {};

      for (Clothe clothe in kart) {
        for (String label in clothe.labels) {
          allLabels[label] = (allLabels[label] ?? 0) + 1;
        }
      }

      User? currentUser = userViewModel.user;

      if (currentUser != null) {
        Map<String, int> updatedLabels = {...currentUser.labels};

        allLabels.forEach((label, frequency) {
          updatedLabels[label] = (updatedLabels[label] ?? 0) + frequency;
        });

        currentUser.labels = updatedLabels;
        await _usersRepository.updateUserLabels(
            currentUser.id, currentUser.labels);

        userViewModel.setUser(currentUser);

        // Registra el evento de compra con Firebase Analytics
        await analytics.logEvent(
          name: "purchase",
          parameters: {
            "User": currentUser.username,
            "Total": totalPrice,
          },
        );

        NotificationService.saveNotification(
            "You have purchased ${items.length} items for $totalPrice \$");

        for (var item in kart) {
          for (String label in item.labels) {
            await analytics.logEvent(
              name: "label_purchase",
              parameters: {
                "label": label,
                "city": currentUser.city,
                "user": currentUser.id,
                "value": item.price,
                "seller": item.seller.id
              },
            );
          }
        }

        // Limpia el carrito
        kart = [];
        totalPrice = 0;
        notifyListeners();
      } else {
        print('No user is logged in.');
      }
    } catch (e) {
      print('Error updating user labels: $e');
    }
  }

  Future<void> sortItemsByUserLabelsAsync(Map<String, int> userLabels) async {
    // Run sorting in an isolate
    items = await compute(_sortItems, [items, userLabels]);
    notifyListeners();
  }

// Separate function to perform the sorting logic in an isolate
  static List<Clothe> _sortItems(List args) {
    List<Clothe> items = args[0];
    Map<String, int> userLabels = args[1];
    items.sort((a, b) {
      int priorityA = a.labels
          .where((label) => userLabels.containsKey(label))
          .fold(0, (sum, label) => sum + userLabels[label]!);
      int priorityB = b.labels
          .where((label) => userLabels.containsKey(label))
          .fold(0, (sum, label) => sum + userLabels[label]!);
      return priorityB.compareTo(priorityA);
    });
    return items;
  }

  void obtainPrice() {
    double totalPrice_ = 0;
    for (var kartItem in kart) {
      totalPrice_ += kartItem.price;
    }

    totalPrice = totalPrice_;
  }

  void updateFeaturedList(Map<String, int> userLabels) {
    // Encuentra la etiqueta más frecuente
    String? mostFrequentLabel;
    int maxFrequency = 0;

    userLabels.forEach((label, frequency) {
      if (frequency > maxFrequency) {
        maxFrequency = frequency;
        mostFrequentLabel = label;
      }
    });

    // Verifica que haya una etiqueta válida antes de continuar
    if (mostFrequentLabel != null) {
      // Filtra los items que contienen la etiqueta más frecuente y no están ya en featured
      featured = items
          .where((item) {
            return item.labels.contains(mostFrequentLabel) &&
                !featured.contains(item);
          })
          .take(4)
          .toList(); // Limita a un máximo de 4 elementos

      // Elimina de items los elementos que están en featured
      items.removeWhere((item) => featured.contains(item));

      notifyListeners();
      print(
          "Featured list updated with items containing label: $mostFrequentLabel");
    }
  }
}
