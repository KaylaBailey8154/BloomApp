import 'package:bloomflutterapp/models/stock.dart';
import 'package:bloomflutterapp/models/user.dart';
import 'package:bloomflutterapp/services/WebBrowser.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:carousel_pro/carousel_pro.dart';

class ProductDetails extends StatelessWidget {
  final Stock stock;
  ProductDetails({this.stock});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    List<String> imageUrls = stock.url;

    List<NetworkImage> images = List<NetworkImage>();
    for(final String img in imageUrls){
      images.add(NetworkImage(img));
    }
    String url = stock.url.first;
    int flowerQuantity = stock.quantity;
    String companyName = stock.companyName;
    String dateAdded = stock.dateAdded;
    int flowerColour = stock.flowerColour;
    int stemLength = stock.stemLength;
    String flowerType = stock.flowerType;

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  SizedBox(
                    height: 350,
                    width: 420,
                    child: Carousel(
                      images: images,
                    ),
                  ),
                  /*Container(
                      height: 350,
                      width: 420,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(40),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              spreadRadius: 0,
                              blurRadius: 20),
                        ],
                      ),
                      child: '$url' != null
                          ? Image.network(
                              '$url',
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/proteaimage.jpg',
                              fit: BoxFit.cover,
                            )),*/
                  Positioned(
                      left: 0.0,
                      top: 20.0,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        iconSize: 30,
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      '$flowerType',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: "Click here to learn more about $flowerType",
                    padding: EdgeInsets.only(top: 10),
                    icon: Icon(
                      Icons.info_outline,
                      size: 25,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      launchURL(flowerType: flowerType);
                    },
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(110, 15, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Quantity: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '$flowerQuantity',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' stems',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(110, 15, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Stem Length: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '$stemLength',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' cm',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(110, 15, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Colour: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    ClipOval(
                      child: Container(
                        color: Color(flowerColour),
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(110, 15, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Date Picked: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '$dateAdded',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(110, 15, 0, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Supplier: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '$companyName',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                width: 300,
                child: RaisedButton(
                  onPressed: () async {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Item Added to Cart"),
                    ));

                    await DatabaseService(uid: user.uid).updateCartStockData(
                        imageUrls,
                        stock.uid,
                        flowerType,
                        flowerQuantity,
                        flowerColour,
                        dateAdded,
                        companyName,
                      stemLength
                        //the 10 is a placeholder for stemlength, we need to insert it into the screen
                    );
                  },
                  color: Colors.red[300],
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
