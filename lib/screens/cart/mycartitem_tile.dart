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

    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          isThreeLine: true,
          title: Text('Flower Type: $flowerType'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Number of stems: $quantity'),
              Text('Supplier: $supplier'),
              Text('Date Picked: $datePicked'),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: ()  async{
                  var deletedItem = await Firestore.instance.collection('cartItems')
                      .where('supplierUID',isEqualTo: cartItem.supplierUID)
                      .where('buyerUID',isEqualTo: cartItem.buyerUID)
                      .where('dateAddedToCart',isEqualTo: cartItem.dateAddedToCart)
                      .where('quantity',isEqualTo: cartItem.quantity)
                      .where('flowerType',isEqualTo: cartItem.flowerType)
                      .getDocuments()
                  .then((snapshot){
                    for(DocumentSnapshot ds in snapshot.documents){
                      ds.reference.delete();
                    }
                  });


                },

              )
            ],
          ),
        ),
      ),
    );
  }
}
