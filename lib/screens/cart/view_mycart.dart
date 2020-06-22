import 'package:bloomflutterapp/models/cartitem.dart';
import 'package:bloomflutterapp/models/user.dart';
import 'package:bloomflutterapp/services/auth.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../buyer/buyer_home.dart';
import 'mycart_list.dart';

class ViewMyCart extends StatefulWidget {
  @override
  _ViewMyCartState createState() => _ViewMyCartState();
}

class _ViewMyCartState extends State<ViewMyCart> {
  final AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    final user = Provider.of<User>(context);
    return StreamProvider<List<CartItem>>.value(
      value: DatabaseService(uid: user.uid).myCart,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  padding: EdgeInsets.fromLTRB(20, 40, 40, 10),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.black,
                  iconSize: 30,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(60, 40, 20, 10),
                  child: Text(
                    'MY CART',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Archivo',
                      //fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
Container(height: 550,width: 400, child: MyCartList(),)
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            child: BottomAppBar(
              shape: CircularNotchedRectangle(),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.home),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => BuyerHome()));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ViewMyCart()));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.chat),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.history),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.account_circle),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.phonelink_ring),
                    onPressed: () async {
                      await _auth.signOut();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
