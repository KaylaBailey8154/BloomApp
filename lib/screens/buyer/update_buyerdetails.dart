import 'package:bloomflutterapp/models/user.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../services/auth.dart';

enum PageEnum {
  settings,
  signout,
}

class BuyerDetailsForm extends StatefulWidget {
  @override
  _BuyerDetailsFormState createState() => _BuyerDetailsFormState();
}

class _BuyerDetailsFormState extends State<BuyerDetailsForm> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String _currentFullName;
  String _currentCompanyName;
  String _currentPhoneNumber;

  _onSelect(PageEnum value) {
    switch (value) {
      case PageEnum.settings:
        Navigator.of(context).pop();
        break;

      case PageEnum.signout:
        _auth.signOut();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      IconButton(
                        icon: Icon(Icons.account_circle),
                        iconSize: 110,
                        onPressed: () {
                          //uploading profile photo
                        },
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
                      SizedBox(
                        height: 40,
                        width: 150,
                        child: RaisedButton(
                          color: Colors.pink[400],
                          child: Text(
                            'Update',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              await DatabaseService(uid: user.uid)
                                  .updateSupplierUserData(
                                      _currentFullName ?? userData.fullName,
                                      _currentCompanyName ??
                                          userData.companyName,
                                      _currentPhoneNumber ??
                                          userData.phoneNumber);
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
              return Container(
                height: 0,
                width: 0,
              );
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
