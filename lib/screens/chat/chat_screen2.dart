

import 'package:bloomflutterapp/models/cartitem.dart';
import 'package:bloomflutterapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloomflutterapp/models/cartitem.dart';
import 'package:bloomflutterapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloomflutterapp/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloomflutterapp/services/auth.dart';
import 'package:provider/provider.dart';

import 'chat_screen.dart';

final _firestore = Firestore.instance;



class ChatScreen2 extends StatefulWidget {


  final CartItem cartItem;
  ChatScreen2({this.cartItem});


  @override
  _ChatScreen2State createState() => _ChatScreen2State();
}

class _ChatScreen2State extends State<ChatScreen2> {
  final AuthService _auth = AuthService();



  @override





  Widget build(BuildContext context) {



    //final cart = Provider.of<CartItem>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('FireStore Demo'),
      ),
      body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RaisedButton(
                child: Text('Start Chat'),
                onPressed: () {

                  createRecord(
                    widget.cartItem.buyerUID,
                    widget.cartItem.supplierUID,
                                );

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatScreen()));
                  },
              ),

            ],
          )), //center

    );
  }



}


void createRecord( String buyerUID, String supplierUID  ) async {


  await _firestore.collection('messages')
      .document(supplierUID+buyerUID)
      .setData({
    //'BuyerUID': buyerUID, //cartItem.buyerUID,
    //'SupplierUID': supplierUID, //cartItem.supplierUID,
  }

  );


}

