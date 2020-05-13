import 'package:bloomflutterapp/services/auth.dart';
import 'package:bloomflutterapp/shared/update_supplierdetails.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    void _showDetailsPanel(){

      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
          child: SupplierDetailsForm(),
        );
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Bloom'),
        backgroundColor: Colors.green[300],
        elevation: 0.0,
        actions: <Widget>[FlatButton.icon(onPressed: () {
          _showDetailsPanel();
        },
            icon: Icon(Icons.settings), label: Text('Settings')),
          FlatButton.icon(onPressed: () async {
            await _auth.signOut();
          }, icon: Icon(Icons.person), label: Text('Logout')),

        ],
      ),
    );
  }
}
