import 'package:bloomflutterapp/models/stock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'flowertypestock_list.dart';

class ViewFlowerTypeStock extends StatelessWidget {

  final String flowerType;
  ViewFlowerTypeStock({this.flowerType});

  //Stock list from snapshot
  List<Stock> _stockListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Stock(
        uid: doc.data['supplierUID'] ?? '',
        flowerColour: doc.data['flowerColour'] ?? '',
        quantity: doc.data['quantity'] ?? 0,
        flowerType: doc.data['flowerType'] ?? '',
        dateAdded: doc.data['dateAdded'] ?? null,
      );
    }).toList();
  }
  //get stocks stream
  Stream<List<Stock>> get flowerTypeStocks {
    return Firestore.instance.collection('stocks')
        .where('flowerType', isEqualTo: flowerType)
        .snapshots()
        .map(_stockListFromSnapshot);
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Stock>>.value(
        value: this.flowerTypeStocks,
      child: Container(
        child:FlowerTypeStockList(),
      ),

    );
  }
}





