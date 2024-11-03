import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wearabouts/core/repositories/model/user.dart';
import 'package:wearabouts/core/repositories/usersRepository.dart';

class UserViewModel with ChangeNotifier {
  final UsersRepository usersRepository;
  User? _user;
  String errorMessage = '';

  UserViewModel(this.usersRepository);

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  Future<void> registerUser({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      User newUser = User(
        id: '',
        username: username,
        password: password,
        email: email,
        sales: 0,
        purchases: 0,
        profilePic: '',
        rating: 5,
        labels: {
          'footwear': 0,
          'leather': 0,
          'outerwear': 0,
          'rainy day': 0,
          'shoes': 0,
          'sports': 0,
          't-shirts': 0,
          'tops': 0,
        },
        latitude: 4.665,
        longitude: -74.0535,
        city: 'Bogota',
      );

      await usersRepository.createUser(newUser);
      errorMessage = '';
    } catch (e) {
      errorMessage = 'Error registering user: $e';
      notifyListeners();
    }
  }

  Future<void> fetchUser(String userId) async {
    try {
      User? fetchedUser = await usersRepository.getUserById(userId);
      if (fetchedUser != null) {
        _user = fetchedUser;

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('cached_user', jsonEncode(fetchedUser.toJson()));

        notifyListeners();
      } else {
        errorMessage = "User not found";
        notifyListeners();
      }
    } catch (e) {
      errorMessage = 'Error fetching user: $e';

      final prefs = await SharedPreferences.getInstance();
      String? cachedUserJson = prefs.getString('cached_user');

      if (cachedUserJson != null) {
        _user = User.fromJson(jsonDecode(cachedUserJson));
      } else {
        errorMessage = 'No cached user data available';
      }

      notifyListeners();
    }
  }

  Future<void> updateUserLabels(String userId, Map<String, int> labels) async {
    try {
      await usersRepository.updateUserLabels(userId, labels);
      if (_user != null) {
        _user!.labels = labels;
        notifyListeners();
      }
    } catch (e) {
      errorMessage = 'Error updating user labels: $e';
      notifyListeners();
    }
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
