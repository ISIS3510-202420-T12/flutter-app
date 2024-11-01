import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
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
  List<Clothe> featured = [];
  double totalPrice = 0;
  double deliveryFee = 3000;

  setItems(List<Clothe> newlist) {
    items = newlist;
    notifyListeners();
  }

  List<Clothe> getMarketItems() => items;

  updateItems(List<Clothe> _items) {
    items = _items;
    notifyListeners();
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

  String addToKart(Clothe item) {
    if (!kart.contains(item)) {
      kart.add(item);
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

        await analytics.logEvent(
          name: "purchase",
          parameters: {
            "User": currentUser.username,
            "Total": totalPrice,
          },
        );

        for (var item in kart) {
          for (String label in item.labels) {
            await analytics.logEvent(
              name: "label_purchase",
              parameters: {
                "label": label,
                "city": currentUser.city,
              },
            );
          }
        }

        kart.clear();
        totalPrice = 0;
        notifyListeners();
      } else {
        print('No user is logged in.');
      }
    } catch (e) {
      print('Error updating user labels: $e');
    }
  }

  void sortItemsByUserLabels(Map<String, int> userLabels) {
    items.sort((a, b) {
      int priorityA = a.labels
          .where((label) => userLabels.containsKey(label))
          .fold(0, (sum, label) => sum + userLabels[label]!);
      int priorityB = b.labels
          .where((label) => userLabels.containsKey(label))
          .fold(0, (sum, label) => sum + userLabels[label]!);
      return priorityB.compareTo(priorityA);
    });
    print("Items organized by user labels");
  }

  void obtainPrice() {
    totalPrice = kart.fold(0, (sum, item) => sum + item.price);
  }

  void updateFeaturedList(Map<String, int> userLabels) {
    String? mostFrequentLabel;
    int maxFrequency = 0;

    userLabels.forEach((label, frequency) {
      if (frequency > maxFrequency) {
        maxFrequency = frequency;
        mostFrequentLabel = label;
      }
    });

    if (mostFrequentLabel != null) {
      featured = items
          .where((item) =>
              item.labels.contains(mostFrequentLabel) &&
              !featured.contains(item))
          .take(4)
          .toList();

      items.removeWhere((item) => featured.contains(item));

      notifyListeners();
      print(
          "Featured list updated with items containing label: $mostFrequentLabel");
    }
  }
}
