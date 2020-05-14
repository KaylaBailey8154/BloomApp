import 'package:bloomflutterapp/models/stock.dart';
import 'package:bloomflutterapp/screens/stock/mystock_tile.dart';
import 'package:bloomflutterapp/screens/stock/stock_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyStockList extends StatefulWidget {
  @override
  _MyStockListState createState() => _MyStockListState();
}

class _MyStockListState extends State<MyStockList> {
  @override
  Widget build(BuildContext context) {

    final stocks = Provider.of<List<Stock>>(context)?? [];




    return ListView.builder(
      itemCount: stocks.length,
      itemBuilder: (context, index){
        return MyStockTile(stock : stocks[index]);
      },

    );
  }
}