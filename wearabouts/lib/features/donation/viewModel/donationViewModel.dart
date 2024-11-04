import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wearabouts/core/repositories/campaignsRepository.dart';
import 'package:wearabouts/core/repositories/donationsRepository.dart';
import 'package:wearabouts/core/repositories/model/Campaign.dart';
import 'package:wearabouts/core/repositories/model/donationPlace.dart';
import 'package:wearabouts/core/repositories/usersRepository.dart';
import 'package:wearabouts/features/auth/viewmodel/userViewModel.dart';
import 'package:wearabouts/services/localNotifications/notificacionService.dart';

import '../../../core/repositories/donationPlacesRepository.dart';
import '../../../core/repositories/model/user.dart';

class DonationViewModel with ChangeNotifier {
  final DonationPlacesRepository _donationPlacesRepository;
  final CampaignsRepository _campaignsRepository;
  final DonationsRepository _donationsRepository;
  final UsersRepository _usersRepository;

  DonationViewModel(this._donationPlacesRepository, this._campaignsRepository,
      this._donationsRepository, this._usersRepository);

  List<DonationPlace> donationPlaces = [];
  List<Campaign> campaigns = [];
  Location locationController = Location();
  LocationData? currentLocation;

  LocationData? get locationData => currentLocation;

  setDonationPlaces(List<DonationPlace> newlist) {
    donationPlaces = newlist;
    notifyListeners();
  }

  setCampaigns(List<Campaign> newList) {
    newList.sort((a, b) => b.reached.compareTo(a.reached));
    campaigns = newList;
    notifyListeners();
  }

  Future<void> populate() async {
    try {
      List<DonationPlace> fetchedItems =
          await _donationPlacesRepository.fetchDonationPlaces();

      List<Campaign> campaignList = await _campaignsRepository.fetchCampaigns();

      // Primero, obtén la ubicación actual
      await fetchLocation();

      // Ahora, si la ubicación actual es válida, ordena los lugares de donación
      if (currentLocation != null) {
        fetchedItems.sort((a, b) {
          double distanceA = _calculateDistance(
            currentLocation!.latitude!,
            currentLocation!.longitude!,
            a.lattitude, // Asegúrate de que DonationPlace tenga estas propiedades
            a.longitude,
          );
          double distanceB = _calculateDistance(
            currentLocation!.latitude!,
            currentLocation!.longitude!,
            b.lattitude,
            b.longitude,
          );
          return distanceA.compareTo(distanceB); // Ordenar por distancia
        });
      }

      setCampaigns(campaignList);
      setDonationPlaces(fetchedItems);
      print("donation places loaded");
    } catch (e) {
      print('Error fetching items: $e');
    }
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double kmPerDegree = 111.0; // Aproximadamente 111 km por grado

    double deltaLat = lat2 - lat1;
    double deltaLon = lon2 - lon1;

    // Calcular la distancia aproximada
    double distance = (deltaLat.abs() + deltaLon.abs()) * kmPerDegree;
    return distance; // Distancia en km
  }

  Future<void> fetchLocation() async {
    bool serviceEnabled = await locationController.serviceEnabled();
    bool couldGetLocation = true;
    if (serviceEnabled) {
      serviceEnabled = await locationController.requestService();
    } else {
      couldGetLocation = false;
    }

    PermissionStatus permisionGranted =
        await locationController.hasPermission();
    if (permisionGranted == PermissionStatus.denied) {
      permisionGranted = await locationController.requestPermission();
      if (permisionGranted != PermissionStatus.granted) {
        couldGetLocation = false;
      }
    }

    currentLocation = await locationController.getLocation();
    notifyListeners();
  }

  Future<void> addDonation(String amount, UserViewModel userViewModel,
      FirebaseAnalytics analytics, Campaign campaign) async {
    double money = double.parse(amount);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //bool alreadyDonated = prefs.getBool('Donated') ?? false;
    bool alreadyDonated = false;
    User? currentUser = userViewModel.user;

    NotificationService.showInstantNotification(
        "You have donated $amount pesos", "Thank you");
    NotificationService.saveNotification(
        "You have donated $amount pesos to " + campaign.name);
    if (!alreadyDonated) {
      NotificationService.scheduleNotification(
          "It's been a while",
          "Your donations can help a lot of people. You still can donate to '" +
              campaign.name +
              "'. We are getting close!",
          DateTime.now().add(const Duration(seconds: 10)));
    }

    await prefs.setBool('Donated', true);

    if (currentUser != null) {
      _donationsRepository.addDonation(
          campaignId: campaign.id,
          date: DateTime.now(),
          quantity: money,
          userId: currentUser.id);

      await analytics.logEvent(name: "donation", parameters: {
        "User": currentUser.username,
        "Quantity": money,
        "Campaing": campaign.name,
        "Date": DateTime.now().toString()
      });
    } else {
      print("No se encontro al usuario actual");
    }
  }
}
