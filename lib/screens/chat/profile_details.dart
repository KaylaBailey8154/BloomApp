import 'package:bloomflutterapp/models/user.dart';
import 'package:flutter/cupertino.dart';

class ProfileDetails extends StatelessWidget {

  final UserData userData;
  ProfileDetails({this.userData});
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(userData.companyName)
            ],
          ),
                  ],
      ),
    );
  }
}
