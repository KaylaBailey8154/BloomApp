import 'package:bloomflutterapp/models/cartitem.dart';
import 'package:bloomflutterapp/screens/buyer/flower_list.dart';
import 'package:bloomflutterapp/screens/buyer/update_buyerdetails.dart';
import 'package:bloomflutterapp/screens/stock/add_stock.dart';
import 'package:bloomflutterapp/screens/stock/view_allstock.dart';
import 'package:bloomflutterapp/screens/stock/view_flowertypestock.dart';
import 'package:bloomflutterapp/screens/stock/view_mystock.dart';
import 'package:bloomflutterapp/screens/supplier/view_allsuppliers.dart';
import 'package:bloomflutterapp/services/auth.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import '../cart/view_mycart.dart';
import '../supplier/update_supplierdetails.dart';

class Post {
  final String title;
  final String description;

  Post(this.title, this.description);
}

class BuyerHome extends StatelessWidget {
  final AuthService _auth = AuthService();
  Future<List<Post>> search(String search) async {
    await Future.delayed(Duration(seconds: 2));
    return List.generate(search.length, (int index) {
      return Post(
        "Title : $search $index",
        "Description :$search $index",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    void _showDetailsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SupplierDetailsForm(),
            );
          });
    }


    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(120),
                  ),
                  gradient: LinearGradient(
                    colors: [Colors.greenAccent, Colors.green],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                  )
                ),
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(160, 40, 20, 0),
                  child: Text(
                    "BROWSE",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Archivo',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 70, 20, 0),
                child: Container(
                  height: 80,
                  width: 350,
                  child: SearchBar<Post>(
                    onSearch: search,
                    onItemFound: (Post post, int index) {
                      return ListTile(
                        title: Text(post.title),
                        subtitle: Text(post.description),
                      );
                    },
                    searchBarStyle: SearchBarStyle(
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 420,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewFlowerTypeStock(flowerType: 'King Protea',)));
                          },
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: Colors.white,
                          child: Row(
                            children: <Widget>[
                              Text(
                                '''King 
Protea''',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Image(
                                image: AssetImage('assets/protea.png'),
                                width: 105,
                                height: 100,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewFlowerTypeStock(flowerType: 'Rose',)));

                          },
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: Colors.white,
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Rose',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Image(
                                image: AssetImage('assets/rose.png'),
                                width: 115,
                                height: 100,
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
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewFlowerTypeStock(flowerType: 'Disa',)));
                          },
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: Colors.white,
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Disa',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Image(
                                image: AssetImage('assets/disa.png'),
                                width: 120,
                                height: 100,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewFlowerTypeStock(flowerType: 'Erica',)));
                          },
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: Colors.white,
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Erica',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Image(
                                image: AssetImage('assets/erica.png'),
                                width: 120,
                                height: 100,
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
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewFlowerTypeStock(flowerType: 'Cape Daisy',)));
                          },
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: Colors.white,
                          child: Row(
                            children: <Widget>[
                              Text(
                                '''Cape 
Daisy''',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Image(
                                image: AssetImage('assets/capedaisy.png'),
                                width: 110,
                                height: 100,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewFlowerTypeStock(flowerType: 'African Iris',)));
                          },
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: Colors.white,
                          child: Row(
                            children: <Widget>[
                              Text(
                                '''African 
 Iris''',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Image(
                                image: AssetImage('assets/iris.png'),
                                width: 95,
                                height: 100,
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
        ],
      ),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BuyerHome()));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ViewMyCart()));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.chat),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.history),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BuyerDetailsForm()));
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


