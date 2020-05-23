import 'package:bloomflutterapp/screens/stock/add_stock.dart';
import 'package:bloomflutterapp/screens/stock/view_allstock.dart';
import 'package:bloomflutterapp/screens/stock/view_mystock.dart';
import 'package:bloomflutterapp/screens/supplier/view_allsuppliers.dart';
import 'package:bloomflutterapp/services/auth.dart';
import 'file:///C:/Bloom/lib/screens/supplier/update_supplierdetails.dart';
import 'package:flutter/material.dart';

class SupplierHome extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showDetailsPanel(){

      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
          child: SupplierDetailsForm(),
        );
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          centerTitle: true,
          title: Text(
            'SUPPLIER HOME',
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
                        _showDetailsPanel();
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
      bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),),
        child: BottomAppBar(
          color: Colors.pinkAccent[100],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              IconButton(
                icon: Icon(Icons.add_circle),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddStock()));
                },
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
    );
  }
}
