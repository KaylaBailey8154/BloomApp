import 'package:bloomflutterapp/models/favorite.dart';
import 'package:bloomflutterapp/models/user.dart';
import 'package:bloomflutterapp/screens/buyer/favorite_list.dart';
import 'package:bloomflutterapp/screens/buyer/view_allfavorites.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget{
  final Favorite favorites;
  FavoritesScreen({this.favorites});

  final _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamProvider<List<Favorite>>.value(
      value: DatabaseService(uid: user.uid).favorites,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.green, Colors.greenAccent])),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 20, 320, 0),
                          child: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Colors.black,
                            iconSize: 30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(115,35,0,0),
                          child: Text(
                            'FAVOURITES',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Archivo',
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(
                        height: 595,
                        width: 450,
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
      ),
    );
  }

}