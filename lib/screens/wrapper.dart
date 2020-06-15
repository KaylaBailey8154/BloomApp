import 'package:bloomflutterapp/models/user.dart';
import 'package:bloomflutterapp/screens/authenticate/authenticate.dart';
import 'package:bloomflutterapp/screens/buyer/buyer_home.dart';
import 'package:bloomflutterapp/screens/stock/add_stock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'supplier/supplier_home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    //return either home or Auth widget
    if (user == null) {
      return Authenticate();
    }

    Firestore.instance
        .collection('users')
        .document(user.uid)
        .get()
        .then((DocumentSnapshot ds) {
      var role = ds['role'];
      if (role == 'buyer') {
        return BuyerHome();
      } else {
        print('supp');
        return SupplierHome();
      }
    });
    print(user.uid);
    return Authenticate();
  }
}
