import 'package:flutter/material.dart';
import '../../models/supplier.dart';

class SupplierDetails extends StatelessWidget {
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

                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 40,0,0),

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


