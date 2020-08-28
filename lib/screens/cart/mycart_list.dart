import 'package:bloomflutterapp/models/cartitem.dart';
import 'package:bloomflutterapp/screens/cart/mycartitem_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCartList extends StatefulWidget {
  @override
  _MyCartListState createState() => _MyCartListState();
}

class _MyCartListState extends State<MyCartList> {
  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<List<CartItem>>(context) ?? [];


    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        return MyCartItemTile(cartItem: cartItems[index]);
      },
    );
  }
}
