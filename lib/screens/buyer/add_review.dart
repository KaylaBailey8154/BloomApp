
import 'package:bloomflutterapp/screens/buyer/review_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

import '../../models/user.dart';
import '../../services/database.dart';
import 'view_allreviews.dart';

class AddReview extends StatefulWidget {
  @override
  _AddReviewState createState() => _AddReviewState();
}
class _AddReviewState extends State<AddReview>{

  int rating = 0;
  final date = new DateFormat('dd-MM-yyyy');

  String fullName = '';
  String review = '';

  Widget _buildStar(int starCount) {
    return InkWell(
      child: Icon(
        Icons.star,
        // size: 30.0,
        color: rating >= starCount ? Colors.orange : Colors.grey,
      ),
      onTap: () {
        setState(() {
          rating = starCount;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(300, 10, 2, 0),
              child: GestureDetector(
                onTap: ()  {
                  showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(20.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              height: 272,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'We Would Love to Hear from You!',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Text(
                                    date.format(DateTime.now()),
                                    style: new TextStyle(
                                        color: Colors.grey[850], fontSize: 14.0),
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      _buildStar(1),
                                      _buildStar(2),
                                      _buildStar(3),
                                      _buildStar(4),
                                      _buildStar(5),
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    'Review:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    onChanged: (value) {
                                      setState(() => review = value);
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      FlatButton(
                                        child: Text(
                                          'CANCEL',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                        onPressed: Navigator.of(context).pop,
                                      ),
                                      FlatButton(
                                        child: Text(
                                          'OK',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                        onPressed: () async {
                                          await DatabaseService(uid: user.uid).updateReviewData(
                                              snapshot.data.fullName,
                                              rating,
                                              review);
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),

                        );
                      }
                  );
                },
                child: Text(
                  'Write a Review',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Container(
              height: 380,
              child: ViewAllReviews(),
            )
          ],
        ),

      );

    });
      }
  }