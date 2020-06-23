import 'package:bloomflutterapp/models/stock.dart';
import 'package:bloomflutterapp/models/user.dart';
import 'package:bloomflutterapp/screens/buyer/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StockTile extends StatelessWidget {
  final Stock stock;
  StockTile({this.stock});

  @override
  Widget build(BuildContext context) {


    int flowerQuantity = stock.quantity;
    String companyName = stock.companyName;
    String dateAdded = stock.dateAdded;
    String flowerColour = stock.flowerColour;
    String url = stock.url;

    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: GestureDetector(
        onTap: (){

          Navigator.push(context,  MaterialPageRoute(builder: (context) => ProductDetails(stock: stock,)));
        },
        child: Card(
          elevation: 10,
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            isThreeLine: true,
            title: Text('Supplier: $companyName'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Number of stems: $flowerQuantity'),
                Text('Flower Colour: $flowerColour'),
                Text('Date Added: $dateAdded'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
