import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class AddStock extends StatefulWidget{
  @override
  _AddStockState createState() => _AddStockState();
}

class _AddStockState extends State<AddStock>{
  final _formKey = GlobalKey<FormState>();

  int _itemCount = 0;

  final date = new DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context){
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
                    height: 400,
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
                    items: null,
                    onChanged: null,
                    disabledHint: Text("Select Flower Type"),
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
                    items: null,
                    onChanged: null,
                    disabledHint: Text("Select Flower Colour"),
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
                    onPressed: (){},
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