
import 'package:bloomflutterapp/screens/buyer/review_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../services/database.dart';

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
      return Column(
        children: [
          Container(
            child: Positioned(
              right: 10,
              child: GestureDetector(
                onTap: () {
                  AlertDialog(
                    title: Center(
                      child: Text(
                        'Review'
                      ),
                    ),
                    content: Column(
                      children: [
                        Text(
                          date.format(DateTime.now()),
                          style: new TextStyle(
                              color: Colors.grey[850], fontSize: 14.0),
                        ),
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
                      ],
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('CANCEL'),
                        onPressed: Navigator.of(context).pop,
                      ),
                      FlatButton(
                        child: Text('OK'),
                        onPressed: () async {
                          await DatabaseService(uid: user.uid).updateReviewData(
                              snapshot.data.fullName,
                              rating,
                              review);
                          Navigator.pop(context);
                        },
                      )
                    ],
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
          ),
          Container(
              height: 200, width: 400,
              child: ReviewList()
          )
        ],
      );
    });
      }
  }