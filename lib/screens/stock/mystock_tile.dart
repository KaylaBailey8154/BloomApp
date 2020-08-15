import 'package:bloomflutterapp/models/stock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MyStockTile extends StatelessWidget {
  final Stock stock;
  MyStockTile({this.stock});

  @override
  Widget build(BuildContext context) {
    String url = stock.url;
    int flowerQuantity = stock.quantity;
    String flowerType = stock.flowerType;
    String dateAdded = stock.dateAdded;
    String flowerColour = stock.flowerColour;

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Container(
        height: 250,
        width: 100,
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          color: Colors.white,
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 250,
                  child: '$url' != null ? Image.network(
                    '$url',
                    fit: BoxFit.cover,
                  )
                      : Image.asset(
                    'assets/proteaimage.jpg',
                    fit: BoxFit.cover,)
              ),
              Text(
                'Flower Type: $flowerType',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                'Number of stems: $flowerQuantity',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 12,
                ),
              ),
              Text(
                'Flower Colour: $flowerColour',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 12,
                ),
              ),
              Text(
                'Date Added: $dateAdded',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
