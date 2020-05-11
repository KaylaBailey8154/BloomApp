import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpForm createState() => _SignUpForm();
}

class _SignUpForm extends State<SignUpForm>{
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'Update your information:',
            style: TextStyle(fontSize: 18.0),
          ),
          IconButton(
            icon: Icon(Icons.account_circle) ,
            iconSize: 20,
            onPressed: (){
              //uploading profile photo
            },
          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none,
                labelText: 'full name'
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none,
                labelText: 'company name'
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none,
                labelText: 'mobile number'
            ),
          ),
          Row(
            children: <Widget>[
              Text(
                'Upload accreditation document:',
              ),
              FlatButton(
                onPressed: (){},
                color: Colors.red[200],
                child: Text(  'Browse...'),
              ),
            ],
          ),
          RaisedButton(
            onPressed: (){},
            color: Colors.green,
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
