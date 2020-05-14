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
  // final List<String> flowers = <String>['Protea', 'Rose', 'Flour'];
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
              IconButton(
                iconSize: 30,
                color: Colors.black,
                padding: EdgeInsets.fromLTRB(20, 30, 370, 0),
                icon: Icon(Icons.arrow_back),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
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
                  Container(
                    width: 158,
                    height: 50,
                    child: DropdownButtonFormField<String>(
                      hint: Text("Select Flower Type"),
                      value:  null,
                      items:['Protea', 'Rose', 'Flour']
                        .map((label) => DropdownMenuItem(
                            child: Text(label),
                            value: label,
                      ))
                        .toList(),
                      onChanged: (value){
                        setState(() => flowerType =value);
                      }
                    ),
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
                  Container(
                    width: 171,
                    height: 50,
                    child: DropdownButtonFormField<String>(
                        hint: Text("Select Flower Colour"),
                        value:  null,
                        items:['Green', 'Red', 'Flour (off-white)']
                            .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                            .toList(),
                        onChanged: (value){
                          setState(() => flowerColour =value);
                        }
                    ),
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
    );
  }
}