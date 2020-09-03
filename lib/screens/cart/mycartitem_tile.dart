import 'package:bloomflutterapp/models/cartitem.dart';
import 'package:bloomflutterapp/models/stock.dart';
import 'package:bloomflutterapp/screens/buyer/product_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../chat/chat_screen.dart';

class MyCartItemTile extends StatelessWidget {
  final CartItem cartItem;
  MyCartItemTile({this.cartItem});


  @override
  Widget build(BuildContext context) {
    int quantity = cartItem.quantity;
    String flowerType = cartItem.flowerType;
    String datePicked = cartItem.datePicked;
    String supplier = cartItem.companyName;
    int stemLength = cartItem.stemLength;
    String url = cartItem.photoUrl.first;


    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: GestureDetector(
        onTap: () {
          //TODO Possibly clickable to bring up details?
        },
        child: Container(
          height: 150,
          width: 50,
          child: Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.white,
            shadowColor: Colors.grey,
            elevation: 5,
            margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: SizedBox(
                          width: 70,
                          height: 70,
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
                        '$flowerType supplied by $supplier',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Max. $quantity stems'),
                    Text('Picked on $datePicked'),
                    Text('$stemLength cm stem length'),
                    Row(
                      children: [
                        RaisedButton(
                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatScreen()));
                            //goes to chatroom

                          },
                          color: Colors.green,
                          child: Text(
                            'Negotiate',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 100),
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              var deletedItem = await Firestore.instance
                                  .collection('cartItems')
                                  .where('supplierUID', isEqualTo: cartItem.supplierUID)
                                  .where('buyerUID', isEqualTo: cartItem.buyerUID)
                                  .where('dateAddedToCart',
                                  isEqualTo: cartItem.dateAddedToCart)
                                  .where('quantity', isEqualTo: cartItem.quantity)
                                  .where('flowerType', isEqualTo: cartItem.flowerType)
                                  .getDocuments()
                                  .then((snapshot) {
                                for (DocumentSnapshot ds in snapshot.documents) {
                                  ds.reference.delete();
                                }
                              });
                            },
                          ),
                        )
                      ],
                    )
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
