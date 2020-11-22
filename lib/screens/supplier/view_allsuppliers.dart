import 'package:bloomflutterapp/models/supplier.dart';
import 'package:bloomflutterapp/screens/buyer/buyer_home.dart';
import 'package:bloomflutterapp/screens/chat/view_mychats.dart';
import 'package:bloomflutterapp/screens/supplier/supplier_list.dart';
import 'package:bloomflutterapp/services/auth.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stock/add_stock.dart';
import '../stock/view_mystock.dart';
import 'supplier_home.dart';
import 'update_supplierdetails.dart';

class ViewAllSuppliers extends StatelessWidget {
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
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SupplierDetailsForm(),
            );
          });
    }

    return StreamProvider<List<Supplier>>.value(
      value: DatabaseService().suppliers,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.green,
        body: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(140, 40, 20, 0),
                  child: Text(
                    "CONTACTS",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Archivo',
                    ),
                  ),
                ),
                Positioned(
                    left: 10.0,
                    top: 25.0,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      iconSize: 30,
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 60, 20, 0),
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
                        backgroundColor: Colors.grey[200],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 480, width: 400, child: SupplierList()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.redAccent[700],
          child: const Icon(
            Icons.add_circle,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddStock()));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: IconButton(
                      icon: Icon(Icons.home),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SupplierHome()));
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewMyStock()));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.chat),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ViewMyChats(), //ChatScreen(otherParty: 'yOEA9tykhJXA0raR6s4KbxvaNOT2',)
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(90, 0, 0, 0),
                    child: IconButton(
                      icon: Icon(Icons.equalizer),
                      onPressed: () {},
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.account_circle),
                    onPressed: () {},
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
      ),
    );
  }
}
