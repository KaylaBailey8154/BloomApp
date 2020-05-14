import 'package:bloomflutterapp/models/supplier.dart';
import 'package:flutter/material.dart';

class SupplierTile extends StatelessWidget {

  final Supplier supplier;
  SupplierTile({this.supplier});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          isThreeLine: true,

          title: Text(supplier.fullName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Text(supplier.email),
              Text(supplier.phoneNumber),

            ],
          ),

        ),
      ),
    );
  }
}