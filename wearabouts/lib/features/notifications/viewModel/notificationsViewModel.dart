import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsViewModel with ChangeNotifier {
  List<String> notifications = [];

  // Cargar notificaciones desde almacenamiento local
  Future<void> loadNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    notifications = prefs.getStringList('notifications') ?? [];
    notifyListeners();
  }

  // Guardar una nueva notificación
  Future<void> addNotification(String notification) async {
    notifications.add(notification);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('notifications', notifications);
    notifyListeners();
  }

  // Eliminar una notificación específica
  Future<void> removeNotification(String notification) async {
    notifications.remove(notification);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('notifications', notifications);
    notifyListeners();
  }

  // Limpiar todas las notificaciones
  Future<void> clearNotifications() async {
    notifications.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('notifications');
    notifyListeners();
  }
}
