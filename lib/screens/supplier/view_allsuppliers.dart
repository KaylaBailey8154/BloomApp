import 'package:bloomflutterapp/models/supplier.dart';
import 'package:bloomflutterapp/screens/supplier/supplier_list.dart';
import 'package:bloomflutterapp/services/auth.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:bloomflutterapp/shared/update_supplierdetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewAllSuppliers extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {



    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
          child: SupplierDetailsForm(
          ),
        );
      });
    }

    return StreamProvider<List<Supplier>>.value(
      value: DatabaseService().suppliers,
      child: Scaffold(
        backgroundColor: Colors.green[300],
        appBar: AppBar(
          title: Text('Bloom'),
          backgroundColor: Colors.green[300],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(onPressed: () async {
              await _auth.signOut();
            }, icon: Icon(Icons.person), label: Text('Logout')),
            FlatButton.icon(onPressed: () => _showSettingsPanel(), icon: Icon(Icons.settings), label: Text('Settings'))
          ],
        ),
        body: Container(
            child: SupplierList()),
      ),
    );
  }
}