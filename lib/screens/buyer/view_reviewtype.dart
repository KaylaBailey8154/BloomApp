import 'package:bloomflutterapp/models/review.dart';
import 'package:bloomflutterapp/screens/buyer/review_list.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewReviewType extends StatelessWidget {
  final String supplier;
  ViewReviewType({this.supplier});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Review>>.value(
      value: DatabaseService(filterValue: supplier).reviewType,
      child: Container(
        child: ReviewList(supplier: supplier),
      ),
    );
  }
}
