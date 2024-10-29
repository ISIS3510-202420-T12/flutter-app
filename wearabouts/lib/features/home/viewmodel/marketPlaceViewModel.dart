import 'package:flutter/material.dart';
import 'package:wearabouts/core/repositories/clothesRepository.dart';
import 'package:wearabouts/core/repositories/model/clothe.dart';
import 'package:wearabouts/core/repositories/usersRepository.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import '../../../core/repositories/model/user.dart';
import '../../auth/viewmodel/userViewModel.dart';

class MarketPlaceViewModel with ChangeNotifier {
  final ClothesRepository _clothesRepository;
  final UsersRepository _usersRepository;

  MarketPlaceViewModel(this._clothesRepository, this._usersRepository);

  List<Clothe> items = [];
  List<Clothe> kart = [];
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
    notifyListeners();
  }

  Future<void> populate() async {
    try {
      List<Clothe> fetchedItems = await _clothesRepository.fetchClothes();
      setItems(fetchedItems);
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
      // Inicializa un mapa para acumular las frecuencias de las etiquetas
      Map<String, int> allLabels = {};

      for (Clothe clothe in kart) {
        for (String label in clothe.labels) {
          // Incrementa la frecuencia de cada etiqueta encontrada en los items del carrito
          allLabels[label] = (allLabels[label] ?? 0) + 1;
        }
      }

      User? currentUser = userViewModel.user;

      if (currentUser != null) {
        // Actualiza el mapa de etiquetas del usuario sumando las frecuencias del carrito
        Map<String, int> updatedLabels = {...currentUser.labels};

        allLabels.forEach((label, frequency) {
          updatedLabels[label] = (updatedLabels[label] ?? 0) + frequency;
        });

        currentUser.labels = updatedLabels;
        await _usersRepository.updateUserLabels(
            currentUser.id, currentUser.labels);

        // Notifica a los listeners del UserViewModel que el usuario ha sido actualizado
        userViewModel.setUser(currentUser);

        // Registra el evento de compra con Firebase Analytics
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

        // Limpia el carrito y restablece el precio total
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

  void sortItemsByUserLabels(Map<String, int> userLabels) {
    // Ordena los items de acuerdo con la frecuencia de las etiquetas del usuario
    items.sort((a, b) {
      // Calcula una "prioridad" para cada item sumando las frecuencias de las etiquetas coincidentes
      int priorityA = a.labels
          .where((label) => userLabels.containsKey(label))
          .fold(0, (sum, label) => sum + userLabels[label]!);
      int priorityB = b.labels
          .where((label) => userLabels.containsKey(label))
          .fold(0, (sum, label) => sum + userLabels[label]!);

      // Compara las prioridades: el item con mayor prioridad debe aparecer primero
      return priorityB.compareTo(priorityA);
    });
    print(
        "Items organizados"); // Notifica a los listeners que los items fueron actualizados
  }

  void obtainPrice() {
    double totalPrice_ = 0;
    for (var kartItem in kart) {
      totalPrice_ += kartItem.price;
    }

    totalPrice = totalPrice_;
  }
}
