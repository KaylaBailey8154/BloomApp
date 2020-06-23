import 'package:bloomflutterapp/screens/authenticate/supplier_register.dart';
import 'package:bloomflutterapp/screens/authenticate/sign_in.dart';
import 'package:bloomflutterapp/screens/stock/add_stock.dart';
import 'package:bloomflutterapp/screens/supplier/view_allsuppliers.dart';
import 'package:bloomflutterapp/screens/wrapper.dart';
import 'package:bloomflutterapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
import 'screens/authenticate/buyer_register.dart';
import 'screens/buyer/buyer_home.dart';
import 'screens/stock/add_stock.dart';
import 'screens/supplier/supplier_home.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application
  //It defines which widget is run first through when the app is opened (so you can see a certain screen immediately)
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
      //TODO create cartstock when adding to cart button is pressed
        //TODO redo stocktile to include supplier photo on left in circle
        //TODO repopulate stocks with new suppliers with profile pics
        //TODO cart functionality showing all cartstock items for current user
        //TODO cart functionality deleting cartstock item from database
        //TODO product details screen using slider for quantity before adding to cart
        home: Wrapper(), //this is the wrapper that defines whether a user is authorised or not and sends them either to the landing page or the sign in screen
      ),
    );
  }
}
