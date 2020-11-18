import 'package:bloomflutterapp/screens/buyer/favorite_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Favorites extends StatelessWidget{
  final Favorites favorites;
  Favorites({this.favorites});

  final _globalKey = GlobalKey<ScaffoldState>();
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
        backgroundColor: Colors.white,
              body: Column(
                children: [
                  Text(
                    'Favorites',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Archivo',
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5,),
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
                                child: FavoritesList(
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