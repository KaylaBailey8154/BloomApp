import 'package:bloomflutterapp/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Bloom'),
        backgroundColor: Colors.green[300],
        elevation: 0.0,
        actions: <Widget>[FlatButton.icon(onPressed: () {},
            icon: Icon(Icons.settings), label: Text('Settings')),
          FlatButton.icon(onPressed: () async {
            await _auth.signOut();
          }, icon: Icon(Icons.person), label: Text('Logout')),

        ],
      ),
    );
  }
}
