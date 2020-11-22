import 'package:bloomflutterapp/screens/buyer/review_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../services/database.dart';

class AddReview extends StatefulWidget {
  final String supplierUID;

  AddReview({this.supplierUID});

  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  double _ratings = 0;
  final date = new DateFormat('dd-MM-yyyy');

  String fullName = '';
  String review = '';

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
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  height: 290,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'We Would Love to Hear from You!',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        date.format(DateTime.now()),
                                        style: new TextStyle(
                                            color: Colors.grey[850],
                                            fontSize: 14.0),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      RatingBar.builder(
                                        initialRating: 1,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (double value) {
                                          print(value);
                                          setState(() {
                                            _ratings = value;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          FlatButton(
                                            child: Text(
                                              'CANCEL',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                            onPressed:
                                                Navigator.of(context).pop,
                                          ),
                                          FlatButton(
                                            child: Text(
                                              'OK',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                            onPressed: () async {
                                              await DatabaseService(
                                                      uid: user.uid)
                                                  .updateReviewData(
                                                      widget.supplierUID,
                                                      snapshot.data.fullName,
                                                      _ratings.toInt(),
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
                          });
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
                  child: ReviewList(),
                )
              ],
            ),
          );
        });
  }
}
