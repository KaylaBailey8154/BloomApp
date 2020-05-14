import 'package:bloomflutterapp/models/stock.dart';
import 'package:bloomflutterapp/models/user.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../services/auth.dart';
import 'view_mystock.dart';

class AddStock extends StatefulWidget{
  final AuthService _auth = AuthService();

  @override
  _AddStockState createState() => _AddStockState();
}

class _AddStockState extends State<AddStock>{

  final _formKey = GlobalKey<FormState>();

  int _itemCount = 0;

  final date = new DateFormat('dd-MM-yyyy');

   String flowerType = '';

   String flowerColour = '';
  // DateTime dateAdded = DateTime.now();
  // List<String> flowers = ['Protea', 'Rose', 'Flour'];
   //List<String> colours = ['Red', 'Green', 'Flour coloured (off-white)'];

  @override
  Widget build(BuildContext context){
    final user = Provider.of<User>(context);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: 700,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/imageplaceholder.jpg'),
                    width: 400,
                    height: 350,
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                  'Flower Type:   ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
              ),
            ),
                  DropdownButton<String>(
                    items: <String>['Protea', 'Rose', 'Flour']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (val){
                      setState(() {
                        flowerType=val;
                      });
                    },
                    hint: Text("Select Flower Type"),

                  ),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Quantity:    ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  _itemCount!=0? new  IconButton(
                    icon: new Icon(Icons.remove),
                    onPressed: ()=>setState(()=>_itemCount--),
                  ):new Container(),
                  new Text(
                      _itemCount.toString()
                  ),
                  new IconButton(
                      icon: new Icon(Icons.add),
                      onPressed: ()=>setState(()=>_itemCount++)
                  ),
                  Text(
                    'in stems',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Colour:   ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  DropdownButton<String>(
                    items: <String>['Red', 'Green', 'Flour (off-white)']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (val){
                      setState(() {
                        flowerColour=val;
                      });
                    },
                    hint: Text("Select Flower Colour"),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Date:   ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    date.format(DateTime.now()),
                    style: new TextStyle(
                        color: Colors.grey[850],
                        fontSize: 14.0),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              SizedBox(
                height: 45,
                width: 200,
                  child: RaisedButton(

                    onPressed: () async {
                      await DatabaseService(uid: user.uid).updateStockData(
                          flowerType, _itemCount, flowerColour);

                      Navigator.pop(context);
                    },
                    color: Colors.red[200],
                      child: Text('Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                ),
              ),
            ),
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
          color: Colors.green[400],
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
               // onPressed: () async { await _auth.signOut();},
              ),
            ],
          ),
        ),
      ),
    );
  }
}