import 'package:bloomflutterapp/models/stock.dart';
import 'package:bloomflutterapp/models/user.dart';
import 'package:bloomflutterapp/screens/stock/stock_list.dart';
import 'package:bloomflutterapp/services/auth.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_stock.dart';
import 'view_mystock.dart';

class ViewAllStock extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
//    void _showSettingsPanel(){
//      showModalBottomSheet(context: context, builder: (context){
//        return Container(
//          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
//          child: SupplierDetailsForm(
//          ),
//        );
//      });
//    }

    return StreamProvider<List<Stock>>.value(
      value: DatabaseService().allStocks,
      child: Scaffold(
        backgroundColor: Colors.pink[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            centerTitle: true,
            title: Text(
              'MARKETPLACE STOCK',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Archivo',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            leading: IconButton(
              padding: EdgeInsets.fromLTRB(20, 0, 100, 0),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.black,
              iconSize: 30,
              icon: Icon(
                Icons.arrow_back,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Container(height: 550, width: 400, child: StockList()),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pinkAccent,
          child: const Icon(
            Icons.add_circle,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddStock()));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            child: BottomAppBar(
              shape: CircularNotchedRectangle(),
              color: Colors.white,
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: IconButton(
                      icon: Icon(Icons.home),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewMyStock()));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.chat),
                    onPressed: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(90, 0, 0, 0),
                    child: IconButton(
                      icon: Icon(Icons.equalizer),
                      onPressed: () {},
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.account_circle),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.phonelink_ring),
                    onPressed: () async {
                      await _auth.signOut();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
