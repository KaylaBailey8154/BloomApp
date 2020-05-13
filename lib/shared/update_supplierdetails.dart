import 'package:bloomflutterapp/models/user.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SupplierDetailsForm extends StatefulWidget {
  @override
  _SupplierDetailsFormState createState() => _SupplierDetailsFormState();
}

class _SupplierDetailsFormState extends State<SupplierDetailsForm> {

  final _formKey = GlobalKey<FormState>();



  String _currentFullName;
  String _currentCompanyName;
  String _currentPhoneNumber;



  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your personal details',
                    style: TextStyle(
                        fontSize: 18 ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: userData.fullName,
                   // decoration: textInputDecoration,
                    validator: (val) => val.isEmpty ? 'Please Enter a Name': null,
                    onChanged: (val) => setState(() => _currentFullName = val),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    initialValue: userData.companyName,
                   // decoration: textInputDecoration,
                    validator: (val) => val.isEmpty ? 'Please Enter a Company Name': null,
                    onChanged: (val) => setState(() =>_currentCompanyName = val),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    initialValue: userData.phoneNumber,
                   // decoration: textInputDecoration,
                    validator: (val) => val.isEmpty ? 'Please Enter a Phone Number': null,
                    onChanged: (val) => setState(() => _currentPhoneNumber = val),
                  ),
                  SizedBox(height: 20,),
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        await DatabaseService(uid: user.uid).updateUserData(

                          _currentFullName ?? userData.fullName,
                          _currentCompanyName ?? userData.companyName,
                          _currentPhoneNumber ?? userData.phoneNumber,

                        );
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            );

          }else{
            //return Loading();
            return null;
          }

        }
    );
  }
}