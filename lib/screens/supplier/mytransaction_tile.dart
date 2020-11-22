import 'package:bloomflutterapp/models/stock.dart';
import 'package:bloomflutterapp/models/transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class MyTransactionTile extends StatelessWidget {
  final Ransaction transaction;
  MyTransactionTile({this.transaction});

  @override
  Widget build(BuildContext context) {
    String url = transaction.photoUrl.first;
    int flowerQuantity = transaction.quantity;
    int totalPrice = transaction.totalPrice;
    String flowerType = transaction.flowerType;
    String datePicked = transaction.datePicked;
    int flowerColour = transaction.flowerColour;

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Container(
        height: 120,
        width: 100,
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.white,
          elevation: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: SizedBox(
                        width: 80,
                        height: 80,
                        child: '$url' != null
                            ? Image.network(
                          '$url',
                          fit: BoxFit.fill,
                        )
                            : Image.asset(
                          'assets/profile.png',
                        )),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Flower Type: $flowerType',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Date: ${transaction.datePicked}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                   'Quantity: $flowerQuantity',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    'Total Price: R$totalPrice',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  GestureDetector(
                    child: Text(
                      'Invoice',
                      style: TextStyle(
                        color: Colors.blue,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () {
                      launch(transaction.invoiceUrl);
                    },
                  )
                ],
              )
            ],
          )),
        ),
      );

  }
}
