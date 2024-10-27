import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:wearabouts/core/repositories/model/donationPlace.dart';

import '../../../core/repositories/donationPlacesRepository.dart';

class DonationViewModel with ChangeNotifier {
  final DonationPlacesRepository _donationPlacesRepository;

  DonationViewModel(this._donationPlacesRepository);

  List<DonationPlace> donationPlaces = [];
  Location locationController = Location();
  LocationData? currentLocation;

  LocationData? get locationData => currentLocation;

  setDonationPlaces(List<DonationPlace> newlist) {
    donationPlaces = newlist;
    notifyListeners();
  }

  Future<void> populate() async {
    try {
      List<DonationPlace> fetchedItems =
          await _donationPlacesRepository.fetchDonationPlaces();
      setDonationPlaces(fetchedItems);
      print("donation places loaded");
    } catch (e) {
      print('Error fetching items: $e');
    }
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
}
