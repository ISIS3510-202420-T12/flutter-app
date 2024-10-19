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
}
