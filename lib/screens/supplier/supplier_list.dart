
import 'package:bloomflutterapp/models/supplier.dart';
import 'package:bloomflutterapp/screens/supplier/supplier_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SupplierList extends StatefulWidget {
  @override
  _SupplierListState createState() => _SupplierListState();
}

class _SupplierListState extends State<SupplierList> {
  @override
  Widget build(BuildContext context) {

    final suppliers = Provider.of<List<Supplier>>(context)?? [];




    return ListView.builder(
      itemCount: suppliers.length,
      itemBuilder: (context, index){
        return SupplierTile(supplier : suppliers[index]);
      },

    );
  }
}
