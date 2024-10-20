import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/user.dart';

class UsersRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<User>> fetchUsers() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection('Users').get();
      return querySnapshot.docs.map((doc) {
        return User.fromDocument(doc);
      }).toList();
    } catch (e) {
      throw Exception("Error fetching Users: $e");
    }
  }

  Future<User> getUserById(String userId) async {
    try {
      DocumentSnapshot doc = await _db.collection('Users').doc(userId).get();
      if (doc.exists) {
        return User.fromDocument(doc);
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      throw Exception("Error fetching user by ID: $e");
    }
  }

  Future<void> updateUser(
      String userId, Map<String, dynamic> updatedData) async {
    try {
      await _db.collection('Users').doc(userId).update(updatedData);
    } catch (e) {
      throw Exception("Error updating user: $e");
    }
  }

  Future<void> updateUserLabels(String userId, List<String> labels) async {
    try {
      await _db.collection('Users').doc(userId).update({
        'Labels': labels,
      });
    } catch (e) {
      throw Exception("Error updating user labels: $e");
    }
  }
}
