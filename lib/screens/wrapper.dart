import 'package:bloomflutterapp/models/user.dart';
import 'package:bloomflutterapp/screens/authenticate/authenticate.dart';
import 'package:bloomflutterapp/screens/buyer/buyer_home.dart';

import 'package:bloomflutterapp/screens/stock/add_stock.dart';
import 'package:bloomflutterapp/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/rolesplitter.dart';
import 'supplier/supplier_home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //return either home or Auth widget
    if (user == null) {
      return Authenticate();
    } else {
      return RoleSplitter(user: user);
    }
  }
}
