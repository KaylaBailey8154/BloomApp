import 'package:bloomflutterapp/models/review.dart';
import 'package:bloomflutterapp/screens/buyer/review_list.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewAllReviews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Review>>.value(
      value: DatabaseService().allReviews,
      child: Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Container(height: 550, width: 400, child: ReviewList())),
      ),
    );
  }
}
