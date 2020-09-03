import 'package:bloomflutterapp/models/stock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyStockTile extends StatelessWidget {
  final Stock stock;
  MyStockTile({this.stock});

  @override
  Widget build(BuildContext context) {
    String url = stock.url.first;
    int flowerQuantity = stock.quantity;
    String flowerType = stock.flowerType;
    String dateAdded = stock.dateAdded;
    int flowerColour = stock.flowerColour;

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Container(
        height: 290,
        width: 100,
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.white,
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 160,
                  width: 250,
                  child: '$url' != null
                      ? Image.network(
                          '$url',
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/proteaimage.jpg',
                          fit: BoxFit.cover,
                        )),
              SizedBox(
                height: 5,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Flower Colour: ',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(flowerColour),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    width: 25,
                    height: 10,
                  ),
                ],
              ),
              Text(
                'Date Added: $dateAdded',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 12,
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  var result = await Firestore.instance
                      .collection('stocks')
                      .where('supplierUID', isEqualTo: stock.uid)
                      .where('companyName', isEqualTo: stock.companyName)
                      .where('dateAdded', isEqualTo: stock.dateAdded)
                      .where('quantity', isEqualTo: stock.quantity)
                      .where('flowerType', isEqualTo: stock.flowerType)
                      .getDocuments()
                      .then((snapshot) {
                    for (DocumentSnapshot ds in snapshot.documents) {
                      ds.reference.delete();
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
