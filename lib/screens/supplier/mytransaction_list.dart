import 'package:bloomflutterapp/models/stock.dart';
import 'package:bloomflutterapp/models/transaction.dart';
import 'package:bloomflutterapp/screens/stock/mystock_tile.dart';
import 'package:bloomflutterapp/screens/supplier/mytransaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyTransactionsList extends StatefulWidget {
  @override
  _MyTransactionsListState createState() => _MyTransactionsListState();
}

class _MyTransactionsListState extends State<MyTransactionsList> {
  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<List<Ransaction>>(context) ?? [];
print(transactions.length);
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return MyTransactionTile(transaction: transactions[index]);
      },
    );
  }
}
