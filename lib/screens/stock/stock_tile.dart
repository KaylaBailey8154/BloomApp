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
    final user = Provider.of<User>(context);
    int flowerQuantity = stock.quantity;
    String flowerType = stock.flowerType;
    String dateAdded = stock.dateAdded;
    String flowerColour = stock.flowerColour;

    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context,  MaterialPageRoute(builder: (context) => ProductDetails()));
        },
        child: Card(
          elevation: 10,
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            isThreeLine: true,
            title: Text('Flower Type: $flowerType'),
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
