import 'package:flutter/material.dart';
import 'package:wearabouts/core/repositories/model/user.dart';
import 'package:wearabouts/core/repositories/usersRepository.dart';

class UserViewModel with ChangeNotifier {
  final UsersRepository usersRepository;

  UserViewModel(this.usersRepository);

  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  Future<void> fetchUser(String userId) async {
    try {
      print("Trying to fetch user");
      User? fetchedUser = await usersRepository.getUserById(userId);

      if (fetchedUser != null) {
        _user = fetchedUser;
        print("User fetched");
        notifyListeners();
      } else {
        print("User with ID $userId not found.");
      }
    } catch (e) {
      print("Error fetching user: $e");
    }
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
