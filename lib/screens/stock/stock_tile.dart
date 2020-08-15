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
        child: Container(
          height: 100,
          width: 50,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(30, 6, 20, 0),
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

                          child: '$url' != null ? Image.network(
                            '$url',
                            fit: BoxFit.fill,
                          )
                              : Image.asset('assets/profile.png',)
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Supplier: $companyName',
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
