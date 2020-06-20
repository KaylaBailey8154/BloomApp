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

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.green, Colors.greenAccent]
          )
          ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 300,0),
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
                    padding: const EdgeInsets.fromLTRB(0, 40,0,0),
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
                         flowerType == 'King Protea'?'R14.50':
                         flowerType == 'Rose'?'R12.00':
                         flowerType == 'Disa'?'R8.50':
                         flowerType == 'Erica'?'R16.00':
                         flowerType == 'Cape Daisy'?'R20.00':
                         flowerType == 'African Iris'?'R13.00':
                             'Yeet'
                        ,
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
                      child: Container(
                          height: 550,
                          width: 400,
                          child: FlowerTypeStockList()),
                    ),

            ]),
      ))],
        ),
      ),
    );
  }
}

