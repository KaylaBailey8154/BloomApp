import 'package:bloomflutterapp/models/stock.dart';
import 'package:bloomflutterapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StockTile extends StatelessWidget {

  final Stock stock;
  StockTile({this.stock});


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    int flowerQuantity = stock.quantity;
    return Padding(
      padding: EdgeInsets.only(top:8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(

          title: Text(stock.flowerType),
          subtitle: Text('$flowerQuantity stems'),

        ),
      ),
    );
  }
}