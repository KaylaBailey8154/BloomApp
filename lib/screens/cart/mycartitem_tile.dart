import 'package:bloomflutterapp/models/cartitem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    String url = cartItem.photoUrl;
    //TODO Possibly clickable to bring up details?
    //TODO Add image of stock to tile?
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(

          isThreeLine: true,
          title: Text('$flowerType supplied by $supplier'),
          subtitle: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Max. $quantity stems'),
                  Text('Picked on $datePicked'),
                  Text('$stemLength cm stem length'),

                ],
              ),
              Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){

                      //function to send you to the chatroom, will likely be either a return or a navigator.push
                    },
                    child: Container(

                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(57)
                    ),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),

                    child: Text('Negotiate'),
                    ),
                  ),
                  IconButton(
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
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
