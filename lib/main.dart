import 'package:bloomflutterapp/screens/authenticate/register.dart';
import 'package:bloomflutterapp/screens/authenticate/sign_in.dart';
import 'package:bloomflutterapp/screens/stock/add_stock.dart';
import 'package:bloomflutterapp/screens/supplier/view_allsuppliers.dart';
import 'package:bloomflutterapp/screens/wrapper.dart';
import 'package:bloomflutterapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
import 'screens/home/home.dart';

void main() {
  runApp(MyApp(),
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

        //Whichever screen Widget is defined in next line will be the screen shown when the app is run
        //home: AddStock(), //this will show the Add Stock screen
        //home: SignIn(), //this would show the sign in screen
        //home: Register(), //this would show the register screen
        home: ViewAllSuppliers(),  //shows all the suppliers (basic 'contact book')
        // home: Wrapper(), //this is the wrapper that defines whether a user is authorised or not and sends them either to the landing page or the sign in screen
       // home: Home(),
      ),
    );
  }
}




