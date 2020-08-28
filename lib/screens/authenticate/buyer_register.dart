import 'package:bloomflutterapp/screens/authenticate/sign_in.dart';
import 'package:bloomflutterapp/services/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class BuyerRegister extends StatefulWidget {
  @override
  _BuyerRegisterState createState() => _BuyerRegisterState();
}

class _BuyerRegisterState extends State<BuyerRegister> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  File _image;
  String url;
  final _picker = ImagePicker();

  // Initially password is obscure
  bool _obscureText = true;

  // text field state
  String email = '';
  String password = '';
  String error = '';
  String fullName = '';
  String companyName = '';
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    void uploadPic() async {
      String profilePic = DateTime.now().toString();
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("profile/");
      StorageUploadTask uploadTask =
          firebaseStorageRef.child(profilePic + ".jpg").putFile(_image);

      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      url = imageUrl.toString();

      print("Image Url= " + url);
    }

    Future getImage() async {
      var image = await _picker.getImage(source: ImageSource.gallery);

      setState(() {
        _image = File(image.path);
        print('Image Path $_image');
        uploadPic();
      });
    }

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
                      padding: EdgeInsets.fromLTRB(10, 140, 0, 0),
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
                        Row(
                          children: <Widget>[
                            Center(
                              child: Padding(
                                  padding: EdgeInsets.only(left: 150),
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.white,
                                    child: ClipOval(
                                      child: SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: (_image != null)
                                            ? Image.file(
                                                _image,
                                                fit: BoxFit.fill,
                                              )
                                            : Image.asset(
                                                'assets/profile.png',
                                                fit: BoxFit.fill,
                                              ),
                                      ),
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                color: Colors.black,
                                iconSize: 30,
                                onPressed: () {
                                  getImage();
                                },
                              ),
                            ),
                          ],
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
                                        color: Colors.green, width: 2),
                                  ),
                                ),
                                validator: (val) =>
                                    val.isEmpty ? 'Enter a name' : null,
                                onChanged: (val) {
                                  setState(() {
                                    fullName = val;
                                  });
                                }),
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
                                        color: Colors.green, width: 2),
                                  ),
                                ),
                                validator: (val) =>
                                    val.isEmpty ? 'Enter a Company Name' : null,
                                onChanged: (val) {
                                  setState(() {
                                    companyName = val;
                                  });
                                }),
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
                                        color: Colors.green, width: 2),
                                  ),
                                ),
                                validator: (val) => val.isEmpty
                                    ? 'Enter a mobile number'
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    phoneNumber = val;
                                  });
                                }),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: SizedBox(
                            height: 40,
                            width: 350,
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
                                labelText: 'email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide:
                                      BorderSide(color: Colors.green, width: 2),
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
                                  labelText: 'password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        color: Colors.green, width: 2),
                                  ),
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
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 45,
                          width: 150,
                          child: RaisedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                try {
                                  await _auth.registerBuyerWithEmailAndPassword(
                                      url,
                                      fullName,
                                      companyName,
                                      phoneNumber,
                                      email,
                                      password);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        // return object of type Dialog
                                        return AlertDialog(
                                          title: Text("Email Verification"),
                                          content: Text(
                                              "Please check your email to verify your account"),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text("Cancel"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            FlatButton(
                                              child: Text("OK"),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SignIn()));
                                              },
                                            )
                                          ],
                                        );
                                      });
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
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                            child: Text("Existing User? Login",
                                style: TextStyle(color: Colors.black)),
                            onTap: () {
                              //widget.toggleView();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignIn()));
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
