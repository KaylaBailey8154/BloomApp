import 'package:bloomflutterapp/screens/chat/chat_screen.dart';
import 'package:bloomflutterapp/screens/stock/add_stock.dart';
import 'package:bloomflutterapp/screens/stock/add_stock_legacy.dart';
import 'package:bloomflutterapp/screens/stock/view_allstock.dart';
import 'package:bloomflutterapp/screens/stock/view_mystock.dart';
import 'package:bloomflutterapp/screens/supplier/view_allsuppliers.dart';
import 'package:bloomflutterapp/services/auth.dart';

import 'package:flutter/material.dart';

import 'update_supplierdetails.dart';

class SupplierHome extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: 700,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(60),
                        ),
                        gradient: LinearGradient(
                          colors: [Colors.greenAccent, Colors.green],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        )),
                    width: MediaQuery.of(context).size.width,
                    height: 150.0,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(80, 40, 20, 0),
                      child: Text(
                        "Welcome Back,",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Archivo',
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 100, 20, 0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddStockMultiplePhotos()),
                            );
                          },
                          child: Container(
                            width: 150,
                            height: 150,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: Colors.white,
                              elevation: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.black54,
                                    size: 70,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Add Stock',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 100, 10, 0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewMyStock()),
                            );
                          },
                          child: Container(
                            width: 150,
                            height: 150,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: Colors.white,
                              elevation: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.edit,
                                    color: Colors.black54,
                                    size: 70,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'My Stock',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 20, 20, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChatScreen()),
                        );
                      },
                      child: Container(
                        width: 150,
                        height: 150,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.white,
                          elevation: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.chat,
                                color: Colors.black54,
                                size: 70,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Negotiation Room',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 10, 0),
                    child: GestureDetector(
                      child: Container(
                        width: 150,
                        height: 150,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.white,
                          elevation: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.equalizer,
                                color: Colors.black54,
                                size: 70,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Analysis',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 20, 20, 0),
                    child: GestureDetector(
                      child: Container(
                        width: 150,
                        height: 150,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.white,
                          elevation: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                color: Colors.black54,
                                size: 70,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Transaction History',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 10, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SupplierDetailsForm()),
                        );
                      },
                      child: Container(
                        width: 150,
                        height: 150,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.white,
                          elevation: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.account_circle,
                                color: Colors.black54,
                                size: 70,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Account',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 20, 20, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewAllSuppliers()),
                        );
                      },
                      child: Container(
                        width: 150,
                        height: 150,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.white,
                          elevation: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.contact_phone,
                                color: Colors.black54,
                                size: 70,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Contacts Book',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 10, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewAllStock()),
                        );
                      },
                      child: Container(
                        width: 150,
                        height: 150,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.white,
                          elevation: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.monetization_on,
                                color: Colors.black54,
                                size: 70,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Marketplace Stock',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
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
        backgroundColor: Colors.redAccent[700],
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ViewMyStock()));
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
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SupplierDetailsForm()));
                  },
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
    );
  }
}
