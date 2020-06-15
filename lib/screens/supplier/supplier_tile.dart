import 'package:bloomflutterapp/models/supplier.dart';
import 'package:bloomflutterapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SupplierTile extends StatelessWidget {
  final Supplier supplier;
  SupplierTile({this.supplier});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          isThreeLine: true,
          title: Text(supplier.fullName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(supplier.companyName),
              Text(supplier.phoneNumber),
            ],
          ),
        ),
      ),
    );
  }
}
