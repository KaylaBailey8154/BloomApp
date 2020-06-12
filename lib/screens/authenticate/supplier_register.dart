import 'package:bloomflutterapp/screens/authenticate/authenticate.dart';
import 'package:bloomflutterapp/screens/stock/add_stock.dart';
import 'package:bloomflutterapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'sign_in.dart';

class SupplierRegister extends StatefulWidget {

  final Function toggleView;
  SupplierRegister({this.toggleView});


  @override
  _SupplierRegisterState createState() => _SupplierRegisterState();
}

class _SupplierRegisterState extends State<SupplierRegister> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // Initially password is obscure
  bool _obscureText = true;

  // text field state
  String email = '';
  String password = '';
  String error = '';
  String fullName = '';
  String companyName = '';
  String phoneNumber = '';
  bool authUploaded = false;


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomPaint(
        painter: ShapesPainter(),
        child: SingleChildScrollView(
          child: Container(
            height: 700,
            child: new Column(
              children: <Widget>[

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(10,140,0,0),
                      child: Text(
                        'Create an Account',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'Archivo',
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: IconButton(
                            icon: Icon(Icons.account_circle) ,
                            iconSize: 80,
                            onPressed: (){
                              //uploading profile photo
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: SizedBox(
                            height: 40,
                            width: 350,
                            child: TextFormField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'full name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                      color: Colors.green,
                                      width: 2
                                  ),
                                ),
                              ),

                              validator: (val)=> val.isEmpty? 'Enter a name' : null,
                                onChanged: (val){
                                  setState(() {
                                    fullName=val;
                                  });
                                }

                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: SizedBox(
                            height: 40,
                            width: 350,
                            child: TextFormField(

                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'company name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                      color: Colors.green,
                                      width: 2
                                  ),
                                ),
                              ),
                                validator: (val)=> val.isEmpty? 'Enter a Company Name' : null,
                                onChanged: (val){
                                  setState(() {
                                    companyName=val;
                                  });
                                }
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: SizedBox(
                            height: 40,
                            width: 350,
                            child: TextFormField(

                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'mobile number',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                      color: Colors.green,
                                      width: 2
                                  ),
                                ),
                              ),
                                validator: (val)=> val.isEmpty? 'Enter a mobile number' : null,
                                onChanged: (val){
                                  setState(() {
                                    phoneNumber=val;
                                  });
                                }
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: SizedBox(
                            height: 40,
                            width: 350,
                            child: TextFormField(
                              validator: (val)=> val.isEmpty? 'Enter an Email' : null,
                              onChanged: (val){
                                setState(() {
                                  email = val;
                                });
                              },
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                    width: 2
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: SizedBox(
                            height: 40,
                            width: 350,
                            child: TextFormField(
                              validator: (val) => val.length <6 ? 'Enter a longer password': null,
                              onChanged: (val){
                                setState(() {
                                  password = val;
                                });
                              },
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'password',
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureText =! _obscureText;
                                      });
                                    },
                                    child: Icon(
                                      _obscureText ? Icons.visibility_off : Icons.visibility,
                                    ),
                                  ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                      color: Colors.green,
                                      width: 2
                                  ),
                                ),
                              ),
                              obscureText: _obscureText,
                            ),
                          ),
                        ),
                        SizedBox(height: 12,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Upload accreditation document:   ',
                            ),
                            SizedBox(
                              height: 30,
                              width: 100,
                              child: FlatButton(
                                onPressed: (){
                                  authUploaded = true;

                                },
                                color: Colors.red[200],
                                child: Text('Browse'),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        SizedBox(
                          height: 45,
                          width: 150,
                          child: RaisedButton(
                            onPressed: () async{
                              if(_formKey.currentState.validate()){
                                try{
                                  if(authUploaded == false){
                                    setState(() {
                                      error = 'Please upload supporting documentation';
                                    });
                                  }

                                  dynamic result = await _auth.registerSupplierWithEmailAndPassword(email, password,fullName,companyName,phoneNumber);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context){
                                        // return object of type Dialog
                                        return AlertDialog(
                                          title: Text ("Email Verification"),
                                          content: Text("Please check your email to verify your account"),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text("Cancel"),
                                              onPressed: () {Navigator.of(context).pop(); },
                                            ),
                                            FlatButton(
                                              child: Text("OK"),
                                              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));},
                                            )
                                          ],
                                        );
                                      }
                                  );
                                }
                                catch(e){
                                  print(e);
                                  setState(() {
                                    error = e.message;
                                  });
                                }
                              }
                            },
                            color: Colors.green,
                            child: Text('Register',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(error,
                          style: TextStyle(color: Colors.red, fontSize: 14),),
                        SizedBox(height: 5,),
                        GestureDetector(
                            child: Text("Existing User? Login",
                                style: TextStyle(
                                    color: Colors.black)),
                            onTap: () {
                             // widget.toggleView();
                              return Authenticate();
                            }
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}

// drawing the background shapes
class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = Colors.green;

    //create path
    var path2 = Path();
    path2.moveTo(0, 0);
    path2.lineTo(150, 120);
    path2.lineTo(300, 0);
    // close the path to form a bounded shape
    path2.close();

    canvas.drawPath(path2, paint);

    paint.color = Colors.greenAccent[400];

    // create a path
    var path = Path();
    path.moveTo(200, 0);
    path.lineTo(320, 160);
    path.lineTo(450, 0);
    // close the path to form a bounded shape
    path.close();

     canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}