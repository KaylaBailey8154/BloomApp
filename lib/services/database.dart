import 'package:bloomflutterapp/models/buyer.dart';
import 'package:bloomflutterapp/models/cartitem.dart';
import 'package:bloomflutterapp/models/stock.dart';
import 'package:bloomflutterapp/models/supplier.dart';
import 'package:bloomflutterapp/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('users');
  final CollectionReference stockCollection =
      Firestore.instance.collection('stocks');
  final CollectionReference cartItemCollection =
  Firestore.instance.collection('cartItems');



  Future updateStockData(
      String url, String flowerType, int quantity, String flowerColour, String companyName) async {
    return await stockCollection.document().setData({
      'supplierUID': uid,
      'url' : url,
      'flowerType': flowerType,
      'quantity': quantity,
      'flowerColour': flowerColour,
      'dateAdded': DateFormat.yMMMd().format(DateTime.now()).toString(),
      'companyName': companyName,
    });
  }

  Future updateSupplierUserData(
     String url,  String fullName, String companyName, String phoneNumber) async {
    return await userCollection.document(uid).setData({
      'url': url,
      'fullName': fullName,
      'companyName': companyName,
      'phoneNumber': phoneNumber,
      'role': 'supplier',
    });
  }

  Future updateBuyerUserData(
      String url, String fullName, String companyName, String phoneNumber) async {
    return await userCollection.document(uid).setData({
      'url': url,
      'fullName': fullName,
      'companyName': companyName,
      'phoneNumber': phoneNumber,
      'role': 'buyer',
    });
  }

  Future updateCartStockData(
      String url, String supplierUID, String flowerType,
      int quantity, String flowerColour, String datePicked, String companyName) async {
    return await cartItemCollection.document().setData({
      'url': url,
      'buyerUID': uid,
      'supplierUID':supplierUID,
      'flowerType':flowerType,
      'quantity':quantity,
      'flowerColour':flowerColour,
      'datePicked': datePicked,
      'dateAddedToCart': DateFormat.yMMMd().format(DateTime.now()).toString(),
      'companyName':companyName,
    });
  }

  //Supplier list from snapshot
  List<Supplier> _supplierListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Supplier(
          url: doc.data['url'] ?? '',
          fullName: doc.data['fullName'] ?? '',
          companyName: doc.data['companyName'] ?? '',
          phoneNumber: doc.data['phoneNumber'] ?? '');
    }).toList();
  }

  //Buyer list from snapshot
  List<Buyer> _buyerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Buyer(
          fullName: doc.data['fullName'] ?? '',
          companyName: doc.data['companyName'] ?? '',
          phoneNumber: doc.data['phoneNumber'] ?? '');
    }).toList();
  }

  //Stock list from snapshot
  List<Stock> _stockListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Stock(
        uid: doc.data['supplierUID'] ?? '',
        url: doc.data['url']?? '',
        flowerColour: doc.data['flowerColour'] ?? '',
        quantity: doc.data['quantity'] ?? 0,
        flowerType: doc.data['flowerType'] ?? '',
        dateAdded: doc.data['dateAdded'] ?? null,
        companyName: doc.data['companyName'] ?? '',
      );
    }).toList();
  }
  //Cart Item list from snapshot
  List<CartItem> _cartItemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return CartItem(
        supplierUID: doc.data['supplierUID'] ?? '',
        buyerUID: doc.data['buyerUID'] ?? '',
        flowerColour: doc.data['flowerColour'] ?? '',
        quantity: doc.data['quantity'] ?? 0,
        flowerType: doc.data['flowerType'] ?? '',
        dateAddedToCart: doc.data['dateAddedToCart'] ?? null,
        datePicked: doc.data['datePicked'] ?? '',
        companyName: doc.data['companyName'] ?? '',
        photoUrl: doc.data['url']?? '',
      );
    }).toList();
  }
  //userData from snapshot

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      url: snapshot.data['url'],
      fullName: snapshot.data['fullName'],
      companyName: snapshot.data['companyName'],
      phoneNumber: snapshot.data['phoneNumber'],
      role: snapshot.data['role'],
    );
  }

  //StockData from snapshot

  Stock _stockDataFromSnapshot(DocumentSnapshot snapshot) {
    return Stock(
      uid: uid,
      url: snapshot.data['url'],
      flowerType: snapshot.data['flowerType'],
      quantity: snapshot.data['quantity'],
      flowerColour: snapshot.data['flowerColour'],
      dateAdded: snapshot.data['dateAdded'],
      companyName: snapshot.data['companyName'],
    );
  }

  //get suppliers stream
  Stream<List<Supplier>> get suppliers {
    return userCollection.snapshots().map(_supplierListFromSnapshot);
  }

  //get buyers stream
  Stream<List<Buyer>> get buyers {
    return userCollection.snapshots().map(_buyerListFromSnapshot);
  }

  //get stocks stream
  Stream<List<Stock>> get myStocks {
    return stockCollection
        .where('supplierUID', isEqualTo: uid)
        .snapshots()
        .map(_stockListFromSnapshot);
  }
  //get cart stream
  Stream<List<CartItem>> get myCart {
    return cartItemCollection
        .where('buyerUID', isEqualTo: uid)
        .snapshots()
        .map(_cartItemListFromSnapshot);
  }

  //get stocks stream
  Stream<List<Stock>> get allStocks {
    return stockCollection.snapshots().map(_stockListFromSnapshot);
  }

  //get stocks doc stream

  Stream<Stock> get stockData {
    return userCollection.document(uid).snapshots().map(_stockDataFromSnapshot);
  }

  //get user doc stream

  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
