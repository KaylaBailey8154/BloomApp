
import 'package:bloomflutterapp/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'buyer_home.dart';

class Cart extends StatefulWidget{


  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart>{

  final AuthService _auth = AuthService();
  int _itemCount = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  padding: EdgeInsets.fromLTRB(20, 40, 40, 10),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  color: Colors.black,
                  iconSize: 30,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(60, 40, 20, 10),
                  child: Text(
                    'MY CART',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Archivo',
                      //fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height:550,
              width: 400,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: RaisedButton(
                        onPressed: () {
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails()));
                        },
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/circle.png'),
                              width: 110,
                              height: 110,
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  'ProteaCo',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Protea/Proteaceae',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Pink',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    _itemCount!=0? new  IconButton(
                                      icon: new Icon(Icons.remove),
                                      onPressed: ()=>setState(()=>_itemCount = _itemCount-10),
                                    ):new Container(),
                                    new Text(
                                        _itemCount.toString()
                                    ),
                                    new IconButton(
                                        icon: new Icon(Icons.add_circle),
                                        onPressed: ()=>setState(()=>_itemCount = _itemCount+10)
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  child: SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: RaisedButton(

                                      onPressed: () async {

                                      },
                                      color: Colors.green,
                                      child: Text('Negotiate',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(70, 0, 0, 0),
                                  child: IconButton(
                                    icon: Icon(Icons.delete),
                                    iconSize: 30,
                                    color: Colors.black,
                                    onPressed: () {},
                                  ),
                                ),
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
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails()));
                        },
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/circle.png'),
                              width: 110,
                              height: 110,
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  '''Heilfontein 
   Proteas''',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Protea/Proteaceae',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Red',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    _itemCount!=0? new  IconButton(
                                      icon: new Icon(Icons.remove),
                                      onPressed: ()=>setState(()=>_itemCount = _itemCount-10),
                                    ):new Container(),
                                    new Text(
                                        _itemCount.toString()
                                    ),
                                    new IconButton(
                                        icon: new Icon(Icons.add_circle),
                                        onPressed: ()=>setState(()=>_itemCount = _itemCount+10)
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  child: SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: RaisedButton(

                                      onPressed: () async {

                                      },
                                      color: Colors.green,
                                      child: Text('Negotiate',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(70, 0, 0, 0),
                                  child: IconButton(
                                    icon: Icon(Icons.delete),
                                    iconSize: 30,
                                    color: Colors.black,
                                    onPressed: () {},
                                  ),
                                ),
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
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails()));
                        },
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/circle.png'),
                              width: 110,
                              height: 110,
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  'FlowerCo',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Protea/Proteaceae',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Red',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    _itemCount!=0? new  IconButton(
                                      icon: new Icon(Icons.remove),
                                      onPressed: ()=>setState(()=>_itemCount = _itemCount-10),
                                    ):new Container(),
                                    new Text(
                                        _itemCount.toString()
                                    ),
                                    new IconButton(
                                        icon: new Icon(Icons.add_circle),
                                        onPressed: ()=>setState(()=>_itemCount = _itemCount+10)
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  child: SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: RaisedButton(

                                      onPressed: () async {

                                      },
                                      color: Colors.green,
                                      child: Text('Negotiate',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(70, 0, 0, 0),
                                  child: IconButton(
                                    icon: Icon(Icons.delete),
                                    iconSize: 30,
                                    color: Colors.black,
                                    onPressed: () {},
                                  ),
                                ),
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
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails()));
                        },
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/circle.png'),
                              width: 110,
                              height: 110,
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  'ProteaInc',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Protea/Proteaceae',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Pink',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    _itemCount!=0? new  IconButton(
                                      icon: new Icon(Icons.remove),
                                      onPressed: ()=>setState(()=>_itemCount = _itemCount-10),
                                    ):new Container(),
                                    new Text(
                                        _itemCount.toString()
                                    ),
                                    new IconButton(
                                        icon: new Icon(Icons.add_circle),
                                        onPressed: ()=>setState(()=>_itemCount = _itemCount+10)
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  child: SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: RaisedButton(

                                      onPressed: () async {

                                      },
                                      color: Colors.green,
                                      child: Text('Negotiate',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(70, 0, 0, 0),
                                  child: IconButton(
                                    icon: Icon(Icons.delete),
                                    iconSize: 30,
                                    color: Colors.black,
                                    onPressed: () {},
                                  ),
                                ),
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
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails()));
                        },
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/circle.png'),
                              width: 110,
                              height: 110,
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  'Stems',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Protea/Proteaceae',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Red',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    _itemCount!=0? new  IconButton(
                                      icon: new Icon(Icons.remove),
                                      onPressed: ()=>setState(()=>_itemCount = _itemCount-10),
                                    ):new Container(),
                                    new Text(
                                        _itemCount.toString()
                                    ),
                                    new IconButton(
                                        icon: new Icon(Icons.add_circle),
                                        onPressed: ()=>setState(()=>_itemCount = _itemCount+10)
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  child: SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: RaisedButton(

                                      onPressed: () async {

                                      },
                                      color: Colors.green,
                                      child: Text('Negotiate',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(70, 0, 0, 0),
                                  child: IconButton(
                                    icon: Icon(Icons.delete),
                                    iconSize: 30,
                                    color: Colors.black,
                                    onPressed: () {},
                                  ),
                                ),
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
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails()));
                        },
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/circle.png'),
                              width: 110,
                              height: 110,
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  'LeafCo',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Protea/Proteaceae',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Red',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    _itemCount!=0? new  IconButton(
                                      icon: new Icon(Icons.remove),
                                      onPressed: ()=>setState(()=>_itemCount = _itemCount-10),
                                    ):new Container(),
                                    new Text(
                                        _itemCount.toString()
                                    ),
                                    new IconButton(
                                        icon: new Icon(Icons.add_circle),
                                        onPressed: ()=>setState(()=>_itemCount = _itemCount+10)
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  child: SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: RaisedButton(

                                      onPressed: () async {

                                      },
                                      color: Colors.green,
                                      child: Text('Negotiate',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(70, 0, 0, 0),
                                  child: IconButton(
                                    icon: Icon(Icons.delete),
                                    iconSize: 30,
                                    color: Colors.black,
                                    onPressed: () {},
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
              topLeft: Radius.circular(30),),
            child: BottomAppBar(
              shape: CircularNotchedRectangle(),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.home),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BuyerHome()));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.chat),
                    onPressed: () {
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.history),
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