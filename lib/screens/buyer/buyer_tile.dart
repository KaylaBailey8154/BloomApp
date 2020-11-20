import 'package:bloomflutterapp/models/buyer.dart';
import 'package:bloomflutterapp/models/supplier.dart';
import 'package:bloomflutterapp/models/user.dart';
import 'package:bloomflutterapp/screens/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BuyerTile extends StatelessWidget {
  final Buyer buyer;
  final String message;
  BuyerTile({this.buyer, this.message});

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
    final user = Provider.of<User>(context);
    String number = buyer.phoneNumber;
    String url = buyer.url;


    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: GestureDetector(onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(otherUid: buyer.uid)));
      },
        child: Container(
          height: 100,
          width: 50,
          child: Card(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: Colors.white,
              shadowColor: Colors.green[800],
              elevation: 10,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: SizedBox(
                            width: 80,
                            height: 80,
                            child: '$url' != null
                                ? Image.network(
                                    '$url',
                                    fit: BoxFit.fill,
                                  )
                                : Image.asset(
                                    'assets/profile.png',
                                  )),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        buyer.fullName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        buyer.companyName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        message,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.green[800],
                          fontSize: 15,
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
