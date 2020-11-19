import 'package:bloomflutterapp/models/review.dart';
import 'package:bloomflutterapp/models/stock.dart';
import 'package:bloomflutterapp/models/user.dart';
import 'package:bloomflutterapp/screens/buyer/view_allreviews.dart';
import 'package:bloomflutterapp/screens/stock/stock_list.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/supplier.dart';
import 'add_review.dart';


class SupplierDetails extends StatefulWidget {
  final Supplier supplier;
  SupplierDetails({this.supplier});
  @override
  _SupplierDetailsState createState() => _SupplierDetailsState();

}



  void launchCaller(String number) async {
    var url = "tel: $number";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  class _SupplierDetailsState extends State<SupplierDetails> {

  final _globalKey = GlobalKey<ScaffoldState>();
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    String url = widget.supplier.url;
    String companyName = widget.supplier.companyName;
    String fullName = widget.supplier.fullName;
    String phoneNumber = widget.supplier.phoneNumber;
    Color _iconColor = Colors.white;



    return  MultiProvider(
      providers: [
        StreamProvider<List<Stock>>.value(
          value: DatabaseService(filterValue: widget.supplier.uid).supplierStocks,),
        StreamProvider<List<Review>>.value(
          value: DatabaseService(filterValue: widget.supplier.uid).reviewType,)
      ],
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
            key: _globalKey,
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(230),
              child: Container(
                decoration: BoxDecoration(
                    gradient:
                    LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.green, Colors.greenAccent])
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          color: Colors.black,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          iconSize: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(120,30,0,0),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            child: ClipOval(child: SizedBox(
                                width: 80,
                                height: 80,
                                child: '$url' != null
                                    ? Image.network(
                                  '$url',
                                  fit: BoxFit.fill,
                                )
                                    : Image.asset(
                                  'assets/profile.png',
                                )),),
                          ),
                        ),
                      ],
                    ),
                    //SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$companyName',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Archivo',
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 2,),
                        IconButton(
                            icon: Icon(Icons.favorite),
                          color: (isPressed) ? Colors.red : Colors.grey,
                          onPressed: () async{
                            setState(() {
                              isPressed = true;
                            });
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Supplier Added to Favorites"),
                            ));
                            await DatabaseService(uid: user.uid).updateFavoriteData( widget.supplier.uid,
                               url, companyName);
                          },
                        )
                      ],
                    ),
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Rating: 4.68',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Archivo',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),*/
                    //SizedBox(height: 5,),
                    Text(
                      '$fullName',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    //SizedBox(height: 5,),
                    GestureDetector(
                      child: Text(
                        '$phoneNumber',
                        style: TextStyle(
                          color: Colors.blue[800],
                          decoration: TextDecoration.underline,
                          fontSize: 15,
                        ),
                      ),
                      onTap: () {
                        launchCaller(phoneNumber);
                      },
                    ),
                    SizedBox(height: 5,),
                    TabBar(
                      labelColor: Colors.black,
                      tabs: [
                        Tab(
                          text: "Stock",
                        ),
                        Tab(
                          text: "Reviews",
                        )
                      ],
                      indicatorColor: Colors.red,
                      indicatorWeight: 5.0,
                    ),

                  ],
                ),
              )
              ),
            body: TabBarView(
              children: <Widget>[
                StockList(),
                AddReview(
                  supplierUID: widget.supplier.uid,
                )
              ],
            ),
            ),
          ),
    );

  }


}

