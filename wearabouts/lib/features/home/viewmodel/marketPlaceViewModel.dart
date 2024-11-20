import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:wearabouts/core/repositories/clothesRepository.dart';
import 'package:wearabouts/core/repositories/model/clothe.dart';
import 'package:wearabouts/core/repositories/usersRepository.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:wearabouts/services/localNotifications/notificacionService.dart';
import 'package:wearabouts/services/networkChecker/networkService.dart';
import '../../../core/repositories/model/user.dart';
import '../../auth/viewmodel/userViewModel.dart';

class MarketPlaceViewModel with ChangeNotifier {
  final ClothesRepository _clothesRepository;
  final UsersRepository _usersRepository;
  final NetworkService _networkService = NetworkService();

  List<Clothe> items = [];
  List<Clothe> kart = [];
  List<Clothe> filteredItems = [];
  Set<String> selectedCategories = {};

  List<Clothe> featured = [];
  double totalPrice = 0;
  double deliveryFee = 3000;

  NetworkService get networkService => _networkService;

  MarketPlaceViewModel(this._clothesRepository, this._usersRepository);

  setItems(List<Clothe> newList) {
    items = newList;
    filteredItems = items;
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
        return item.labels
            .any((label) => selectedCategories.contains(label.toLowerCase()));
      }).toList();
    }
    notifyListeners();
  }

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
      saveToCache();
      print("Market items loaded");
    } catch (e) {
      print('Error fetching items: $e');
    }
  }

  addToKart(Clothe item) {
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
      bool isConnected = await _networkService.hasInternetConnection();
      if (!isConnected) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text("No internet connection. Please connect and try again."),
          ),
        );
        return;
      }

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

        NotificationService.saveNotification(
            "You have purchased ${kart.length} items for $totalPrice \$");

        kart = [];
        totalPrice = 0;
        notifyListeners();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Your order has been processed!"),
          ),
        );
      } else {
        print('No user is logged in.');
      }
    } catch (e) {
      print('Error processing payment: $e');
    }
  }

  Future<void> sortItemsByUserLabelsAsync(Map<String, int> userLabels) async {
    items = await compute(_sortItems, [items, userLabels]);
    notifyListeners();
  }

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
          .where((item) {
            return item.labels.contains(mostFrequentLabel) &&
                !featured.contains(item);
          })
          .take(4)
          .toList();

      items.removeWhere((item) => featured.contains(item));

      notifyListeners();
      print(
          "Featured list updated with items containing label: $mostFrequentLabel");
    }
  }

  Future<void> saveToCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cacheManager = DefaultCacheManager();

    List<String> serializedItems =
        items.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList('cached_items', serializedItems);

    for (Clothe item in items) {
      for (String url in item.imagesURLs) {
        await cacheManager.downloadFile(url);
      }
    }
    print("Cache saved successfully.");
  }

  Future<void> loadFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cacheManager = DefaultCacheManager();

    List<String>? serializedItems = prefs.getStringList('cached_items');
    if (serializedItems != null) {
      items = serializedItems
          .map((item) => Clothe.fromJson(jsonDecode(item)))
          .toList();
    }

    for (Clothe item in items) {
      for (String url in item.imagesURLs) {
        await cacheManager.getSingleFile(url).catchError((error) {
          print("Error loading image from cache: $error");
        });
      }
    }
    notifyListeners();
  }
}
