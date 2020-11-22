import 'package:bloomflutterapp/screens/stock/flowertypestock_list.dart';
import 'package:bloomflutterapp/services/auth.dart';
import 'package:flutter/material.dart';

class Post {
  final String title;
  final String description;

  Post(this.title, this.description);
}

class FlowerList extends StatefulWidget {
  final String flowerType;

  FlowerList({this.flowerType});

  @override
  _FlowerListState createState() => _FlowerListState();
}

class _FlowerListState extends State<FlowerList> {
  final AuthService _auth = AuthService();
  String supplier;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.green, Colors.greenAccent])),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 300, 0),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.black,
                    iconSize: 30,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                    child: Text(
                      widget.flowerType,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Archivo',
                        //fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 70, 20, 0),
                  child: Container(
                    height: 80,
                    width: 350,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          supplier = value;
                        });
                      },
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
                        widget.flowerType == 'King Protea'
                            ? 'R14.50'
                            : widget.flowerType == 'Rose'
                                ? 'R12.00'
                                : widget.flowerType == 'Disa'
                                    ? 'R8.50'
                                    : widget.flowerType == 'Erica'
                                        ? 'R16.00'
                                        : widget.flowerType == 'Cape Daisy'
                                            ? 'R20.00'
                                            : widget.flowerType ==
                                                    'African Iris'
                                                ? 'R13.00'
                                                : 'Yeet',
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
                  child: Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                          height: 550,
                          width: 400,
                          child: FlowerTypeStockList(
                            supplier: supplier,
                          )),
                    ),
                  ]),
                ))
          ],
        ),
      ),
    );
  }
}
