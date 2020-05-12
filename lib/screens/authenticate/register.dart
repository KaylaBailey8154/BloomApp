import 'package:bloomflutterapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

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
          child: new Column(
            children: <Widget>[

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0,90,0,0),
                    child: Text(
                      'BLOOM',
                      style: TextStyle(
                        fontSize: 40,
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

              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 100, 10, 0),
                        child: SizedBox(
                          height: 50,
                          width: 300,
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
                                border: InputBorder.none,
                                labelText: 'email'
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: SizedBox(
                          height: 50,
                          width: 300,
                          child: TextFormField(
                            obscureText: true,
                            validator: (val) => val.length <6 ? 'Enter a longer password': null,
                            onChanged: (val){
                              setState(() {
                                password = val;
                              });
                            },
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                labelText: 'password'
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50,),
                      RaisedButton(
                        onPressed: () async{
                          if(_formKey.currentState.validate()){

                            dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                            if(result == null)
                            {
                              setState(() {
                                error = 'please supply a valid email';
                              });
                            }}
                        },
                        color: Colors.green,
                        child: Text('Register',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),

                      ),
                      SizedBox(height: 12,),
                      Text(error,
                        style: TextStyle(color: Colors.red, fontSize: 14),),
                      SizedBox(height: 20,),
                      GestureDetector(
                          child: Text("Existing User? Login",
                              style: TextStyle(
                                  color: Colors.black)),
                          onTap: () {
                            widget.toggleView();

                            // do what you need to do when the text is gets clicked
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