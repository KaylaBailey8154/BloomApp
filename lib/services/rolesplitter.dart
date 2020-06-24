import 'package:bloomflutterapp/models/user.dart';
import 'package:bloomflutterapp/screens/buyer/buyer_home.dart';
import 'package:bloomflutterapp/screens/supplier/supplier_home.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class RoleSplitter extends StatelessWidget {
  final User user;
  const RoleSplitter({Key key, this.user}):super(key:key);




  @override
  Widget build(BuildContext context) {

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context,snapshot){
          if(snapshot.hasData){

            UserData userData = snapshot.data;

            if(userData.role == 'supplier'){
              return SupplierHome();
            }else if(userData.role == 'buyer'){
      return BuyerHome();
            }else{
              return Text('role incorrectly named');
            }

        }else{
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SpinKitFadingCube(
                color: Colors.redAccent[200],
                size: 80,
              ),
              SizedBox(height: 20),
              Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Archivo',
                  color: Colors.white,
                ),
              )
            ],
          )

        ),
      );

  }
});
    }}
