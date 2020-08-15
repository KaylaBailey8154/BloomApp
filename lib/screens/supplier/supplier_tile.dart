import 'package:bloomflutterapp/models/supplier.dart';
import 'package:bloomflutterapp/models/user.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SupplierTile extends StatelessWidget {
  final Supplier supplier;
  SupplierTile({this.supplier});

  void launchCaller(String number) async{
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
    String number = supplier.phoneNumber;
    String url = supplier.url;

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return Padding(
      padding: EdgeInsets.only(top: 5),
        child: Container(
          height: 100,
          width: 50,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(30, 6, 20, 0),

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

                          child: '$url' != null ? Image.network(
                            '$url',
                            fit: BoxFit.fill,
                          )
                              : Image.asset('assets/profile.png',)
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      supplier.fullName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      supplier.companyName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 5,),
                    GestureDetector(
                      child: Text(
                        '$number',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onTap: () {
                        launchCaller(number);
                      },
                    )
                  ],
                )
              ],
            )
          ),
        ),
    );
  }
}
