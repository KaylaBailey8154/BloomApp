import 'package:bloomflutterapp/models/stock.dart';
import 'package:bloomflutterapp/models/user.dart';
import 'package:bloomflutterapp/screens/stock/mystock_list.dart';
import 'package:bloomflutterapp/screens/stock/stock_list.dart';
import 'package:bloomflutterapp/services/auth.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewMyStock extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

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
      value: DatabaseService(uid: user.uid).myStocks,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            centerTitle: true,
            title: Text(
              'CONTACTS BOOK',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Archivo',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            backgroundColor: Colors.green,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),),
            ),
            leading: IconButton(
              padding: EdgeInsets.fromLTRB(50, 0, 100, 0),
              onPressed: (){},
              color: Colors.black,
              iconSize: 30,
              icon: Icon(Icons.arrow_back,),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.brown,
                boxShadow: [
                  BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                ],
              ),
              height: 550,
              width: 400,
              child: MyStockList()),
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),),
          child: BottomAppBar(
            color: Colors.green[400],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: () {
                  },
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                  },
                ),
                IconButton(
                  icon: Icon(Icons.chat),
                  onPressed: () {
                  },
                ),
                IconButton(
                  icon: Icon(Icons.equalizer),
                  onPressed: () {
                  },
                ),
                IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: (){

                  },
                ),
                IconButton(
                  icon: Icon(Icons.phonelink_ring),
                  onPressed: () async { await _auth.signOut();},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}