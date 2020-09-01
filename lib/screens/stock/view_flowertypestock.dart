import 'package:bloomflutterapp/models/stock.dart';
import 'package:bloomflutterapp/screens/buyer/flower_list.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewFlowerTypeStock extends StatelessWidget {
  final String flowerType;
  ViewFlowerTypeStock({this.flowerType});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Stock>>.value(
      value: DatabaseService(filterValue: flowerType).flowerTypeStocks,
      child: Container(
        child: FlowerList(flowerType: flowerType),
      ),
    );
  }
}
