import 'package:flutter/material.dart';
import 'package:wearabouts/core/repositories/activitiesRepository.dart';
import 'package:wearabouts/core/repositories/model/Activity.dart';

class Notificationsviewmodel with ChangeNotifier {
  ActivitiesRepository _activitiesRepository;

  Notificationsviewmodel(this._activitiesRepository);

  List<Activity> activities = [];

  Future<void> populate(String userId) async {
    try {
      List<Activity> fetchedItems =
          await _activitiesRepository.fetchActivitiesByUser(userId);
      setNotifications(fetchedItems);
      print("Notifications loaded");
    } catch (e) {
      print('Error fetching notifications: $e');
    }
  }

  void setNotifications(List<Activity> fetchedItems) {
    try {
      activities = fetchedItems;
      notifyListeners();
    } catch (e) {
      print('Error setting notifications: $e');
    }
  }
}
