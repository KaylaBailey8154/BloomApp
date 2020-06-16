import 'package:bloomflutterapp/screens/buyer/product_details.dart';
import 'package:bloomflutterapp/screens/stock/flowertypestock_list.dart';
import 'package:bloomflutterapp/services/auth.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import '../supplier/update_supplierdetails.dart';

class Post {
  final String title;
  final String description;

  Post(this.title, this.description);
}

class FlowerList extends StatelessWidget {
  final String flowerType;

  FlowerList({this.flowerType});
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
      backgroundColor: Colors.green,
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    padding: EdgeInsets.fromLTRB(20, 40, 40, 10),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.black,
                    iconSize: 30,
                  ),
                  Padding(
                    //TODO sort out the padding so that the name shows up in the middle of the page
                    padding: EdgeInsets.fromLTRB(60, 40, 20, 10),
                    child: Text(
                     flowerType ,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Archivo',
                        //fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
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
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(110, 150, 20, 20),
                    child: Text(
                      'Avg. Price:',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Archivo',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 150, 20, 20),
                    child: Text(
                      'R14.50',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Archivo',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),



          Container(
            height: 495,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(40),
              ),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(height: 550, width: 400, child: FlowerTypeStockList()),
                  ),

          ]),
    ))],
      ),
    );
  }
}

                    /*RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetails()));
                      },
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/circle.png'),
                            width: 110,
                            height: 80,
                          ),
                          Text(
                            'ProteaCo',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(50, 10, 10, 10),
                                child: Text(
                                  '70 stems',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(50, 0, 10, 10),
                                child: Text(
                                  'Pink',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: RaisedButton(
                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => FlowerList()));
                      },
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/circle.png'),
                            width: 110,
                            height: 80,
                          ),
                          Text(
                            '''Heilfontein 
   Proteas''',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 10, 10, 10),
                                child: Text(
                                  '120 stems',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 0, 10, 10),
                                child: Text(
                                  'Red',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: RaisedButton(
                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => FlowerList()));
                      },
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/circle.png'),
                            width: 110,
                            height: 80,
                          ),
                          Text(
                            'FlowerCo',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(50, 10, 10, 10),
                                child: Text(
                                  '200 stems',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(50, 0, 10, 10),
                                child: Text(
                                  'Red',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: RaisedButton(
                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => FlowerList()));
                      },
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/circle.png'),
                            width: 110,
                            height: 80,
                          ),
                          Text(
                            'ProteaInc',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(50, 10, 10, 10),
                                child: Text(
                                  '550 stems',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(50, 0, 10, 10),
                                child: Text(
                                  'Pink',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: RaisedButton(
                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => FlowerList()));
                      },
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/circle.png'),
                            width: 110,
                            height: 80,
                          ),
                          Text(
                            'Stems',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(80, 10, 10, 10),
                                child: Text(
                                  '500 stems',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(80, 0, 10, 10),
                                child: Text(
                                  'Red',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: RaisedButton(
                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => FlowerList()));
                      },
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/circle.png'),
                            width: 110,
                            height: 80,
                          ),
                          Text(
                            'LeafCo',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(80, 10, 10, 10),
                                child: Text(
                                  '300 stems',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(80, 0, 10, 10),
                                child: Text(
                                  'Red',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),*/
