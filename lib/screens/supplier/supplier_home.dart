import 'package:bloomflutterapp/screens/stock/add_stock.dart';
import 'package:bloomflutterapp/screens/stock/view_allstock.dart';
import 'package:bloomflutterapp/screens/stock/view_mystock.dart';
import 'package:bloomflutterapp/screens/supplier/view_allsuppliers.dart';
import 'package:bloomflutterapp/services/auth.dart';

import 'package:flutter/material.dart';

import 'update_supplierdetails.dart';
import 'update_supplierdetails.dart';

class SupplierHome extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

   // void _showDetailsPanel(){

      //showModalBottomSheet(context: context, builder: (context){
        //return Container(
         // padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
          //child: SupplierDetailsForm(),
        //);
      //});
    //}

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: true,
          title: Text(
            'HOME',
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
            bottom: Radius.circular(30),),
          ),
          ),
      ),
      body: Container(
        height:510 ,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> AddStock()),
                        );
                      },
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.purpleAccent,
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Add Stock',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image(
                            image: AssetImage('assets/stock.png'),
                            width: 80,
                            height: 80,
                          )
                        ],
                      ),
                    ),
                  ),
                   Padding(
                     padding: EdgeInsets.fromLTRB(0, 20, 10, 0),
                     child: RaisedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewMyStock()));
                        },
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Colors.yellowAccent,
                        child: Row(
                          children: <Widget>[
                            Text(
                              'My Stock',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Image(
                              image: AssetImage('assets/edit.png'),
                              width: 80,
                              height: 80,
                            )
                          ],
                        ),
                      ),
                   ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: RaisedButton(
                      onPressed: () {},
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.orangeAccent,
                      child: Row(
                        children: <Widget>[
                          Text(
                            ''' Negotiation
       Room''' ,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image(
                            image: AssetImage('assets/chat.png'),
                            width: 70,
                            height: 80,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 10, 0),
                    child: RaisedButton(
                      onPressed: () {},
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.lightGreenAccent,
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Analytics',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image(
                            image: AssetImage('assets/analytics.png'),
                            width: 80,
                            height: 80,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: RaisedButton(
                      onPressed: () {

                      },
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.blueAccent,
                      child: Row(
                        children: <Widget>[
                          Text(
                            ''''Transaction 
        History''',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image(
                            image: AssetImage('assets/invoices.png'),
                            width: 70,
                            height: 80,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 10, 0),
                    child: RaisedButton(
                      onPressed: (){
                        //_showDetailsPanel();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SupplierDetailsForm()));
                      },
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.grey,
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Account',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image(
                            image: AssetImage('assets/account.png'),
                            width: 80,
                            height: 80,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAllSuppliers()),
                        );
                      },
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.redAccent,
                      child: Row(
                        children: <Widget>[
                          Text(
                            '''Contacts Book''',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image(
                            image: AssetImage('assets/contacts.png'),
                            width: 60,
                            height: 80,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 10, 0),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAllStock()),);
                      },
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.tealAccent,
                      child: Row(
                        children: <Widget>[
                          Text(
                            ''''Marketplace 
        Stock''',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image(
                            image: AssetImage('assets/marketplace.png'),
                            width: 50,
                            height: 80,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add_circle,
        ),
        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => AddStock()));},
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
              topLeft: Radius.circular(30),),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewMyStock()));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.chat),
                  onPressed: () {
                  },
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(90, 0, 0, 0),
                  child: IconButton(
                    icon: Icon(Icons.equalizer),
                    onPressed: () {
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: (){

                  },
                ),
                IconButton(
                  icon: Icon(Icons.phonelink_ring),
                  onPressed: () async {
                    Navigator.pop(context);
                    await _auth.signOut();},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
