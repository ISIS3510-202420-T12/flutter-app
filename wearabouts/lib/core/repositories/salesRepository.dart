import 'model/sales.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SalesRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Sales>> fetchSales() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection('Sales').get();
      List<Sales> salesList = [];

      for (var doc in querySnapshot.docs) {
        try {
          Sales sale = Sales.fromDocument(doc);
          salesList.add(sale);
        } catch (e) {
          print("Error loading document ${doc.id}: $e");
        }
      }

      return salesList;
    } catch (e) {
      throw Exception("Error fetching sales: $e");
    }
  }

  Future<void> addSale(Sales sale) async {
    try {
      await _db.collection('Sales').add(sale.toJson());
    } catch (e) {
      throw Exception("Error adding sale: $e");
    }
  }

  Future<void> updateSale(String saleId, Map<String, dynamic> updates) async {
    try {
      await _db.collection('Sales').doc(saleId).update(updates);
    } catch (e) {
      throw Exception("Error updating sale $saleId: $e");
    }
  }

  Future<List<Sales>> fetchSalesByUser(String userId) async {
    try {
      print('Buscando $userId');
      QuerySnapshot querySnapshot = await _db.collection('Sales').get();

      List<Sales> userSalesList = [];

      for (var doc in querySnapshot.docs) {
        try {
          Sales sale = Sales.fromDocument(doc);
          print("Añadiendo sale");
          userSalesList.add(sale);
        } catch (e) {
          print("Error loading document ${doc.id}: $e");
        }
      }

      return userSalesList;
    } catch (e) {
      throw Exception("Error fetching sales for user: $e");
    }
  }

  Future<void> deleteSale(String saleId) async {
    try {
      await _db.collection('Sales').doc(saleId).delete();
    } catch (e) {
      throw Exception("Error deleting sale $saleId: $e");
    }
  }

  Future<Sales?> getSaleById(String saleId) async {
    try {
      DocumentSnapshot doc = await _db.collection('Sales').doc(saleId).get();
      if (doc.exists) {
        return Sales.fromDocument(doc);
      }
      return null;
    } catch (e) {
      throw Exception("Error fetching sale $saleId: $e");
    }
  }
}
