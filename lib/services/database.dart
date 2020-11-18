import 'package:bloomflutterapp/models/buyer.dart';
import 'package:bloomflutterapp/models/cartitem.dart';
import 'package:bloomflutterapp/models/favorite.dart';
import 'package:bloomflutterapp/models/review.dart';
import 'package:bloomflutterapp/models/stock.dart';
import 'package:bloomflutterapp/models/supplier.dart';
import 'package:bloomflutterapp/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  final String uid;
  final String filterValue;
  DatabaseService({this.uid, this.filterValue});

  //collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('users');
  final CollectionReference stockCollection =
      Firestore.instance.collection('stocks');
  final CollectionReference cartItemCollection =
      Firestore.instance.collection('cartItems');
  final CollectionReference reviewsCollection =
      Firestore.instance.collection('reviews');
  final CollectionReference favoritesCollection =
  Firestore.instance.collection('favorites');


  Future updateReviewData(String supplieruid, String fullName, int rating, String reviews) async {
    return await reviewsCollection.document().setData({
      'buyerUID': uid,
      'supplierUID':supplieruid,
      'fullName': fullName,
      'dateAdded': DateFormat.yMMMd().format(DateTime.now()).toString(),
      'rating': rating,
      'review': reviews
    });
  }


  Future updateStockData(List<String> url, String flowerType,  int quantity, int stemLength,
      int flowerColour, String companyName, ) async {
    return await stockCollection.document().setData({
      'supplierUID': uid,
      'url': url,
      'flowerType': flowerType,
      'stemLength': stemLength,
      'quantity': quantity,
      'flowerColour': flowerColour,
      'dateAdded': DateFormat.yMMMd().format(DateTime.now()).toString(),
      'companyName': companyName,
    });
  }

  Future updateSupplierUserData(String url, String fullName, String companyName,
      String phoneNumber) async {
    return await userCollection.document(uid).setData({
      'url': url,
      'fullName': fullName,
      'companyName': companyName,
      'phoneNumber': phoneNumber,
      'role': 'supplier',
    });
  }

  Future updateBuyerUserData(String url, String fullName, String companyName,
      String phoneNumber) async {
    return await userCollection.document(uid).setData({
      'url': url,
      'fullName': fullName,
      'companyName': companyName,
      'phoneNumber': phoneNumber,
      'role': 'buyer',
    });
  }

  Future updateCartStockData(
      List<String> url,
      String supplierUID,
      String flowerType,
      int quantity,
      int flowerColour,
      String datePicked,
      String companyName,
      int stemLength) async {
    return await cartItemCollection.document().setData({
      'url': url,
      'buyerUID': uid,
      'supplierUID': supplierUID,
      'flowerType': flowerType,
      'stemLength': stemLength,
      'quantity': quantity,
      'flowerColour': flowerColour,
      'datePicked': datePicked,
      'dateAddedToCart': DateFormat.yMMMd().format(DateTime.now()).toString(),
      'companyName': companyName,
    });
  }

  Future updateFavoriteData(String supplieruid, String url, String companyName) async {
    return await favoritesCollection.document().setData({
      'supplierUID':supplieruid,
      'url': url,
      'companyName': companyName,
    });
  }

  //Supplier list from snapshot
  List<Supplier> supplierListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Supplier(
          uid: doc.documentID ?? '',
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
  List<Stock> stockListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {

      return Stock(
        uid: doc.data['supplierUID'] ?? '',
        url: List.from(doc.data['url']) ?? [],
        flowerColour: doc.data['flowerColour'] ?? 0,
        stemLength: doc.data['stemLength'] ?? 0,
        quantity: doc.data['quantity'] ?? 0,
        flowerType: doc.data['flowerType'] ?? '',
        dateAdded: doc.data['dateAdded'] ?? null,
        companyName: doc.data['companyName'] ?? '',

      );

    }).toList();
  }

  //Review list from snapshot
  List<Review> reviewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Review(
        uid: doc.data['buyerUID'] ?? '',
        supplieruid: doc.data['supplierUID'] ?? '',
        fullName: doc.data['fullName'] ?? '',
        dateAdded: doc.data['dateAdded'] ?? null,
        rating: doc.data['rating'] ?? 0,
        reviews: doc.data['review'] ?? '',
      );
    }).toList();
  }

  //Favorite list from snapshot
  List<Favorite> favoriteListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Favorite(
        supplieruid: doc.data['supplierUID'] ?? '',
        url: doc.data['url'] ?? '',
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
        flowerColour: doc.data['flowerColour'] ?? 0,
        quantity: doc.data['quantity'] ?? 0,
        flowerType: doc.data['flowerType'] ?? '',
        dateAddedToCart: doc.data['dateAddedToCart'] ?? null,
        datePicked: doc.data['datePicked'] ?? '',
        companyName: doc.data['companyName'] ?? '',
        photoUrl: List.from(doc.data['url']) ?? '',
        stemLength: doc.data['stemLength'] ?? 0,
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
      stemLength: snapshot.data['stemLength'],
      quantity: snapshot.data['quantity'],
      flowerColour: snapshot.data['flowerColour'],
      dateAdded: snapshot.data['dateAdded'],
      companyName: snapshot.data['companyName'],
    );
  }

  //get suppliers stream
  Stream<List<Supplier>> get suppliers {
    return userCollection.snapshots().map(supplierListFromSnapshot);
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
        .map(stockListFromSnapshot);
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
    return stockCollection.snapshots().map(stockListFromSnapshot);
  }

  //get reviews stream
  Stream<List<Review>> get allReviews {
    return reviewsCollection.snapshots().map(reviewListFromSnapshot);
  }

  //get favorites stream
  Stream<List<Favorite>> get allFavorites {
    return favoritesCollection.snapshots().map(favoriteListFromSnapshot);
  }

  //get review for specific supplier steam
  Stream<List<Review>> get reviewType {
    return Firestore.instance
        .collection('reviews')
        .where('supplierUID', isEqualTo: filterValue)
        .snapshots()
        .map(reviewListFromSnapshot);
  }

  //get flower type stocks stream
  Stream<List<Stock>> get flowerTypeStocks {
    return Firestore.instance
        .collection('stocks')
        .where('flowerType', isEqualTo: filterValue)
        .snapshots()
        .map(stockListFromSnapshot);
  }

  //get supplier stocks stream
  Stream<List<Stock>> get supplierStocks {
    return Firestore.instance
        .collection('stocks')
        .where('supplierUID', isEqualTo: filterValue)
        .snapshots()
        .map(stockListFromSnapshot);
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
