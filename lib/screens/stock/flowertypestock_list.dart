import 'package:bloomflutterapp/models/stock.dart';
import 'package:bloomflutterapp/screens/buyer/product_details.dart';
import 'package:bloomflutterapp/screens/stock/mystock_tile.dart';
import 'package:bloomflutterapp/screens/stock/stock_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlowerTypeStockList extends StatefulWidget {
  String supplier;
  FlowerTypeStockList({this.supplier});
  @override
  _FlowerTypeStockList createState() => _FlowerTypeStockList();
}

class _FlowerTypeStockList extends State<FlowerTypeStockList> {
  @override
  Widget build(BuildContext context) {

    final stocks = Provider.of<List<Stock>>(context) ?? [];
    List<Stock> filteredStocks = stocks.where((Stock s) {
      if(widget.supplier==null){
        return s.uid != null;
      }else{
      return s.companyName.contains(widget.supplier);
    }}).toList();


    return ListView.builder(
      itemCount: filteredStocks.length,
      itemBuilder: (context, index) {
        return  StockTile(stock: filteredStocks[index])
            //Navigator.push(context,  MaterialPageRoute(builder: (context) => ProductDetails())))
        ;
      },
    );
  }
}
