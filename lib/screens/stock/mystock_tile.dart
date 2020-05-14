import 'package:bloomflutterapp/models/stock.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyStockTile extends StatelessWidget {

  final Stock stock;
  MyStockTile({this.stock});


  @override
  Widget build(BuildContext context) {

    int flowerQuantity = stock.quantity;
    String flowerType = stock.flowerType;
    String dateAdded = stock.dateAdded;
    String flowerColour = stock.flowerColour;


    return Padding(
      padding: EdgeInsets.only(top:8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(

          title: Text('$flowerColour $flowerType ($flowerQuantity)'),
          subtitle: Text('Added On: $dateAdded'),

        ),
      ),
    );
  }
}