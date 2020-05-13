import 'package:cloud_firestore/cloud_firestore.dart';

class Stock {
  final String uid;
  final String flowerType;
  final int quantity;
  final String flowerColour;
  final DateTime dateAdded;

  Stock({this.uid, this.flowerType, this.quantity, this.flowerColour, this.dateAdded});


}