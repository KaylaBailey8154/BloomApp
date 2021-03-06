import 'package:bloomflutterapp/models/stock.dart';
import 'package:bloomflutterapp/models/supplier.dart';
import 'package:bloomflutterapp/screens/buyer/product_details.dart';
import 'package:bloomflutterapp/screens/buyer/supplier_details.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StockTile extends StatelessWidget {
  final Stock stock;
  StockTile({this.stock});

  @override
  Widget build(BuildContext context) {
    int flowerQuantity = stock.quantity;
    String companyName = stock.companyName;
    String dateAdded = stock.dateAdded;
    int flowerColour = stock.flowerColour;
    int stemLength = stock.stemLength;
    String url = stock.url.first;

    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetails(
                        stock: stock,
                      )));
        },
        child: Container(
          height: 100,
          width: 50,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                    Row(
                      children: [
                        Text(
                          'Supplier: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                            onTap: () async{


                                QuerySnapshot query = await Firestore.instance.collection(
                                    'users')
                                    .where(
                                    'companyName', isEqualTo: companyName)
                                    .getDocuments();
                            Supplier supplier = DatabaseService().supplierListFromSnapshot(query).first;




                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SupplierDetails(
                                        supplier: supplier,
                                        // need to get document name where companyName in users
                                        //collection is the same as companyName here
                                        //then map that into a supplier object
                                        // then feed it into supplierDetails parameter
                                      )));
                            },
                            child: Text(
                              '$companyName',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                fontSize: 14,
                              ),
                            )),
                      ],
                    ),
                    Text(
                      'Number of stems: $flowerQuantity',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Stem Length: $stemLength',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12,
                      ),
                    ),
                    Row(
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
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
