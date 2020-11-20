import 'package:bloomflutterapp/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Container(
                height: 300,
                width: 450,
                child: userData.url != null
                    ? Image.network(
                  userData.url,
                  fit: BoxFit.cover,
                )
                    : Image.asset(
                  'assets/imageplaceholder.jpg',
                  fit: BoxFit.cover,
                )),
          SizedBox(
            height: 5,
          ),
          Text(
            userData.fullName,
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontFamily: 'Archivo',
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
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            child: Text(
              userData.phoneNumber,
              style: TextStyle(
                color: Colors.blue[800],
                decoration: TextDecoration.underline,
                fontSize: 15,
              ),
            ),
            onTap: () {
              launchCaller(userData.phoneNumber);
            },
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
