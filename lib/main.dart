import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: MyHomePage(),
    );
  }

}

class MyHomePage extends StatefulWidget{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage>{

  // text field state
  String email = '';
  String password = '';

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
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                 Padding(
                   padding: EdgeInsets.fromLTRB(10, 100, 10, 0),
                      child: SizedBox(
                        height: 50,
                        width: 300,
                        child: TextFormField(
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              labelText: 'email'
                          ),

                        ),
                      ),
                    ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: SizedBox(
                      height: 50,
                      width: 300,
                      child: TextFormField(
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            labelText: 'password'
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 30, 10, 10),
                    child:  GestureDetector(
                        child: Text("Forgot Password?",
                            style: TextStyle(decoration: TextDecoration.underline,
                                color: Colors.black)),
                        onTap: () {
                          // do what you need to do when "Forgot Password?" gets clicked
                        }
                    )
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    onPressed: (){},
                    color: Colors.green,
                    child: Text('Login',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),

                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 30, 10, 10),
                      child:  GestureDetector(
                          child: Text("New User? SignUp",
                              style: TextStyle(
                                  color: Colors.black)),
                          onTap: () {
                            // do what you need to do when the text is gets clicked
                          }
                      )
                  ),
                ],
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




