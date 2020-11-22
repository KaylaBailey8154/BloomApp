import 'package:bloomflutterapp/screens/wrapper.dart';
import 'package:bloomflutterapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

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
        home:
            Wrapper(), //this is the wrapper that defines whether a user is authorised or not and sends them either to the landing page or the sign in screen
        //testing matt's branch
      ),
    );
  }
}
