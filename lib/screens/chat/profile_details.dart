import 'package:bloomflutterapp/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileDetails extends StatelessWidget {
  final UserData userData;
  ProfileDetails({this.userData});

  void launchCaller(String number) async {
    var url = "tel: $number";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return Scaffold(
      body: CustomPaint(
        painter: ShapesPainter(),
        child: Container(
          height: 700,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 30, 320, 0),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.black,
                  iconSize: 30,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: SizedBox(
                          width: 150,
                          height: 150,
                          child: userData.url != null
                              ? Image.network(
                                  userData.url,
                                  fit: BoxFit.fill,
                                )
                              : Image.asset(
                                  'assets/profile.png',
                                )),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      userData.fullName,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontFamily: 'Archivo',
                      ),
                    ),
                  ),
                  Text(
                    userData.companyName,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Container(
                    width: 350,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 2, color: Colors.grey)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.phone_in_talk_sharp,
                          color: Colors.green,
                          size: 40,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          child: Text(
                            userData.phoneNumber,
                            style: TextStyle(
                              color: Colors.blue[800],
                              decoration: TextDecoration.underline,
                              fontSize: 20,
                            ),
                          ),
                          onTap: () {
                            launchCaller(userData.phoneNumber);
                          },
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 15,
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
    var rect = Rect.fromLTWH(-5, 0, 500, 200);

    // draw the rectangle using the paint
    canvas.drawRect(rect, paint);

    paint.color = Colors.green;

    // create a path
    var path = Path();
    path.moveTo(600, 0);
    path.lineTo(530, 320);
    path.lineTo(200 - size.height, 0);
    // close the path to form a bounded shape
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
