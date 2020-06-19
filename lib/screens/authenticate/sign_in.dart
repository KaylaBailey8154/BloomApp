import 'package:bloomflutterapp/models/user.dart';
import 'package:bloomflutterapp/screens/authenticate/user_typeselection.dart';
import 'package:bloomflutterapp/screens/buyer/buyer_home.dart';
import 'package:bloomflutterapp/screens/rolesplitter.dart';
import 'package:bloomflutterapp/screens/supplier/supplier_home.dart';
import 'package:bloomflutterapp/services/auth.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'forgot_password.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // Initially password is obscure
  bool _obscureText = true;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return Scaffold(
      body: CustomPaint(
        painter: ShapesPainter(),
        child: Container(
          height: 700,
          child: SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 90, 0, 0),
                      child: Text(
                        'BLOOM',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[200],
                          fontFamily: 'Archivo',
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image(
                      image: AssetImage('assets/bloomlogo.png'),
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  color: Colors.redAccent,
                  child: Text(
                    error,
                    maxLines: 3,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
                          child: SizedBox(
                            height: 50,
                            width: 300,
                            child: TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? 'Enter an Email' : null,
                              onChanged: (val) {
                                setState(() {
                                  email = val;
                                });
                              },
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  labelText: 'email'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: SizedBox(
                            height: 50,
                            width: 300,
                            child: TextFormField(
                              validator: (val) => val.length < 6
                                  ? 'Enter a longer password'
                                  : null,
                              onChanged: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  labelText: 'password',
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    child: Icon(
                                      _obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                  )),
                              obscureText: _obscureText,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(180, 0, 0, 0),
                          child: GestureDetector(
                              child: Text("Forgot Password?",
                                  style: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.underline)),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPassword()));
                                // do what you need to do when the text is gets clicked
                              }),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              //print('valid');
                              try {
                                User result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                               // Navigator.push(context, MaterialPageRoute(builder: (context)=> RoleSplitter(user: result)));

                               /* if(result is User){
                                String uid = result.uid;
                                Firestore.instance
                                    .collection('users')
                                    .document(uid)
                                    .get()
                                    .then((DocumentSnapshot ds) {
                                  var role = ds['role'];
                                  if (role == 'buyer') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BuyerHome()));
                                  } else if (role == 'supplier') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SupplierHome()));
                                  }
                                });}
                                if (result is !User) {
                                  setState(() {
                                    error =
                                        "Please check your email to verify your account before logging in";
                                  });
                                }*/
                              } catch (e) {
                                print(e);
                                setState(() {
                                  error = e.message;
                                });
                              }
                            }
                          },
                          color: Colors.green,
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                            child: Text("New User? Sign Up",
                                style: TextStyle(color: Colors.black)),
                            onTap: () {
                              //widget.toggleView();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UserTypeSelection()));

                              // do what you need to do when the text is gets clicked
                            }),
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

    // set the paint color to be white
    paint.color = Colors.white;

    // Create a rectangle with size and width same as the canvas
    var rect = Rect.fromLTWH(-5, 0, 500, 800);

    // draw the rectangle using the paint
    canvas.drawRect(rect, paint);

    paint.color = Colors.green;

    // create a path
    var path = Path();
    path.moveTo(530, 0);
    path.lineTo(530, 650);
    path.lineTo(200 - size.height, 0);
    // close the path to form a bounded shape
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
