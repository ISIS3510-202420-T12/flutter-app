import 'dart:convert'; // Para convertir JSON
import 'dart:io'; // Para leer archivos
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<void> populateFirestore() async {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  // Leer y decodificar el archivo JSON de usuarios
  // final String usersJsonString =
  //     await rootBundle.loadString('assets/dummyData/users.json');
  // final List<dynamic> usersList = jsonDecode(usersJsonString);

  // // Poblar la colección "Users"
  // for (var user in usersList) {
  //   await _db.collection('Users').add(user);
  // }

  // print('Users added successfully');
//CLOTHES ______________
  final String clothesJsonString =
      await rootBundle.loadString('assets/dummyData/clothes.json');
  final List<dynamic> clothesList = jsonDecode(clothesJsonString);

  // Poblar la colección "Clothes"
  for (var clothe in clothesList) {
    // Buscar el documento del vendedor en Firestore por el Username
    var sellerSnapshot = await _db
        .collection('Users')
        .where('Username', isEqualTo: clothe['Seller'])
        .limit(1)
        .get();

    if (sellerSnapshot.docs.isNotEmpty) {
      clothe['Seller'] = sellerSnapshot.docs.first.reference;

      await _db.collection('Clothes').add(clothe);
    }
  }

  print('Clothes added successfully');
}
