import 'package:bloomflutterapp/screens/authenticate/buyer_register.dart';
import 'package:bloomflutterapp/screens/authenticate/supplier_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserTypeSelection extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => BuyerRegister()) );
                  },
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Colors.pink[300],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Buyer  ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Archivo',
                          fontSize: 25,
                        ),
                      ),
                      Image(
                        image: AssetImage('assets/buyer.png'),
                        width: 180,
                        height: 200,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => SupplierRegister()) );
                  },
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Colors.yellow[300],
                  child: Row(
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/supplier.png'),
                        width: 160,
                        height: 200,
                      ),
                      Text(
                        'Supplier',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Archivo',
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}