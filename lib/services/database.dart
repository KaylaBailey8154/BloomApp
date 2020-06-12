import 'package:bloomflutterapp/models/stock.dart';
import 'package:bloomflutterapp/models/supplier.dart';
import 'package:bloomflutterapp/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference  stockCollection = Firestore.instance.collection('stocks');

  Future updateStockData(String flowerType, int quantity, String flowerColour) async{
    return await stockCollection.document().setData({
      'supplierUID': uid,
      'flowerType': flowerType,
      'quantity': quantity,
      'flowerColour': flowerColour,
      'dateAdded': DateFormat.yMMMd().format(DateTime.now()).toString(),
    });
  }

  Future updateSupplierUserData(String fullName, String companyName, String phoneNumber) async{
    return await userCollection.document(uid).setData({
      'fullName': fullName,
      'companyName': companyName,
      'phoneNumber': phoneNumber,
      'role': 'supplier',
    });
  }
  Future updateBuyerUserData(String fullName, String phoneNumber) async{
    return await userCollection.document(uid).setData({
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'role': 'buyer',
    });
  }
  //Supplier list from snapshot
  List<Supplier> _supplierListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Supplier(
          fullName: doc.data['fullName'] ?? '',
          companyName: doc.data['companyName']?? '',
          phoneNumber:  doc.data['phoneNumber'] ?? ''
      );
    }).toList();

  }

  //Stock list from snapshot
  List<Stock> _stockListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Stock(
          uid: doc.data['supplierUID'] ?? '',
          flowerColour: doc.data['flowerColour'] ?? '',
          quantity: doc.data['quantity']?? 0,
          flowerType:  doc.data['flowerType'] ?? '',
        dateAdded: doc.data['dateAdded']?? null,
      );
    }).toList();

  }
  //userData from snapshot

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){

    return UserData(
      uid: uid,
      fullName: snapshot.data['fullName'],
      companyName: snapshot.data['companyName'],
      phoneNumber: snapshot.data['phoneNumber'],
    );

  }

  //StockData from snapshot

  Stock _stockDataFromSnapshot(DocumentSnapshot snapshot){

    return Stock(
      uid: uid,
      flowerType: snapshot.data['flowerType'],
      quantity: snapshot.data['quantity'],
      flowerColour: snapshot.data['flowerColour'],
      dateAdded: snapshot.data['dateAdded'],
    );

  }

  //get suppliers stream
  Stream<List<Supplier>> get suppliers{
    return userCollection.snapshots()
        .map(_supplierListFromSnapshot);
  }

  //get stocks stream
  Stream<List<Stock>> get myStocks{
    return stockCollection.where('supplierUID', isEqualTo: uid).snapshots()
        .map(_stockListFromSnapshot);
  }



  //get stocks stream
  Stream<List<Stock>> get allStocks{
    return stockCollection.snapshots()
        .map(_stockListFromSnapshot);
  }
 
  //get stocks doc stream

  Stream<Stock> get stockData{
    return userCollection.document(uid).snapshots()
        .map(_stockDataFromSnapshot);
  }
 
 
  //get user doc stream

  Stream<UserData> get userData{
    return userCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

  void homePageRedirect() {



  }


}