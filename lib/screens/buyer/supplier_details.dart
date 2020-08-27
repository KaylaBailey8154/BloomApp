import 'package:bloomflutterapp/screens/buyer/product_details.dart';
import 'package:bloomflutterapp/screens/stock/flowertypestock_list.dart';
import 'package:bloomflutterapp/services/auth.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import '../../models/supplier.dart';
import '../supplier/update_supplierdetails.dart';

class SupplierDetails extends StatelessWidget { //TODO: extract supplier details from company name in stock
  final Supplier supplier;
  SupplierDetails({this.supplier});

  @override
  Widget build(BuildContext context) {

    //String url = supplier.url;
    //String companyName = supplier.companyName;

    return Flexible(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.green, Colors.greenAccent]
            )
        ),
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
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
                    Padding(
                      padding: const EdgeInsets.only(top:30),
                      child: Center(
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            /*child: SizedBox(
                                width: 80,
                                height: 80,

                                child: '$url' != null ? Image.network(
                                  '$url',
                                  fit: BoxFit.fill,
                                )
                                    : Image.asset('assets/profile.png',)
                            ),*/
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 40,0,0),
                        /*child: Text(
                          companyName ,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Archivo',
                            //fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),*/
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(110, 165, 20, 20),
                          child: Text(
                            'Rating:',



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
                  height: 482,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: TabBar(
                      labelColor: Colors.black,
                      tabs: [
                        Tab(text: "Stock",),
                        Tab(text: "Reviews",)
                      ],
                      indicatorColor: Colors.red,
                      indicatorWeight: 5.0,
                    ),
                  ),
                ),
                /*TabBarView(
                  children: <Widget>[
                    //FlowerTypeStockList(),
                    //Reviews(),
                  ],
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}


