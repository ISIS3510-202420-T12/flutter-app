import 'package:flutter/material.dart';
import 'package:location/location.dart';

class DonationViewModel with ChangeNotifier {
  Location locationController = Location();
  LocationData? currentLocation;

  LocationData? get locationData => currentLocation;

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
