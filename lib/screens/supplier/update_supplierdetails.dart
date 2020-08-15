import 'dart:math';
import 'dart:io';
import 'package:bloomflutterapp/models/user.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';

import '../../services/auth.dart';

enum PageEnum {
  settings,
  signout,
}

class SupplierDetailsForm extends StatefulWidget {
  @override
  _SupplierDetailsFormState createState() => _SupplierDetailsFormState();
}

class _SupplierDetailsFormState extends State<SupplierDetailsForm> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool authUploaded = false;

  String _currentUrl;
  String _currentFullName;
  String _currentCompanyName;
  String _currentPhoneNumber;
  String _currentEmail;

  File _image;
  String url;


  final _picker = ImagePicker();

  _onSelect(PageEnum value) {
    switch (value) {
      case PageEnum.settings:
        Navigator.of(context).pop();
        break;

      case PageEnum.signout:
        Navigator.pop(context);
        sleep(const Duration(seconds: 1));
        _auth.signOut();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {

    void uploadPic() async{
      String profilePic = DateTime.now().toString();
      StorageReference firebaseStorageRef= FirebaseStorage.instance
          .ref()
          .child("profile/");
      StorageUploadTask uploadTask=firebaseStorageRef.child(profilePic+ ".jpg").putFile(_image);

      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      url = imageUrl.toString();

      print("Image Url= " + url);

      _currentUrl = url;
    }

    Future getImage() async {
      var image = await _picker.getImage(source: ImageSource.gallery);

      setState(() {
        _image = File(image.path);
        print('Image Path $_image');
        uploadPic();

      });
    }

    final user = Provider.of<User>(context);
    return Scaffold(
      body: StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData userData = snapshot.data;
              return CustomPaint(
                painter: ShapesPainter(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            //padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Colors.black,
                            iconSize: 30,
                            icon: Icon(
                              Icons.arrow_back,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                            child: Text(
                              'Account Details',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          PopupMenuButton<PageEnum>(
                            onSelected: _onSelect,
                            itemBuilder: (context) =>
                                <PopupMenuEntry<PageEnum>>[
                              PopupMenuItem<PageEnum>(
                                value: PageEnum.settings,
                                child: Text("Settings"),
                              ),
                              PopupMenuItem<PageEnum>(
                                value: PageEnum.signout,
                                child: Text("Sign Out"),
                              )
                            ],
                          ),
                        ],
                      ),
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

                                        child:  (_image != null)?Image.file(_image, fit: BoxFit.fill,)
                                            :
                                        userData.url != null ? Image.network(
                                          userData.url,
                                          fit: BoxFit.fill,
                                        )
                                            : Image.asset('assets/profile.png')
                                    ),
                                  ),
                                )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,50,0,0),
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
                      SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        width: 350,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name',
                          ),
                          initialValue: userData.fullName,
                          // decoration: textInputDecoration,
                          validator: (val) =>
                              val.isEmpty ? 'Please Enter a Name' : null,
                          onChanged: (val) =>
                              setState(() => _currentFullName = val),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        width: 350,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Company Name',
                          ),
                          initialValue: userData.companyName,
                          // decoration: textInputDecoration,
                          validator: (val) => val.isEmpty
                              ? 'Please Enter a Company Name'
                              : null,
                          onChanged: (val) =>
                              setState(() => _currentCompanyName = val),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        width: 350,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone Number',
                          ),
                          initialValue: userData.phoneNumber,
                          // decoration: textInputDecoration,
                          validator: (val) => val.isEmpty
                              ? 'Please Enter a Phone Number'
                              : null,
                          onChanged: (val) =>
                              setState(() => _currentPhoneNumber = val),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
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
                              onPressed: () {
                                authUploaded = true;
                              },
                              color: Colors.green,
                              child: Text('Browse'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 40,
                        width: 150,
                        child: RaisedButton(
                          color: Colors.redAccent[700],
                          child: Text(
                            'Update',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              await DatabaseService(uid: user.uid)
                                  .updateSupplierUserData(
                                _currentUrl ?? userData.url,
                                _currentFullName ?? userData.fullName,
                                _currentCompanyName ?? userData.companyName,
                                _currentPhoneNumber ?? userData.phoneNumber,
                              );
                              Navigator.pop(context);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              //return Loading();
              return null;
            }
          }),
    );
  }
}

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // set the paint color to be white
    paint.color = Colors.green;
    paint.strokeWidth = 10;
    paint.style = PaintingStyle.fill;

    // Create a rectangle with size and width same as the canvas
    canvas.drawCircle(Offset(400, 30), 100, paint);

    paint.color = Colors.green;
    paint.strokeWidth = 10;
    paint.style = PaintingStyle.fill;

    // Create a rectangle with size and width same as the canvas
    canvas.drawCircle(Offset(10, 650), 90, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
