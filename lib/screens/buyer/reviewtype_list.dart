import 'package:bloomflutterapp/models/review.dart';
import 'package:bloomflutterapp/models/stock.dart';
import 'package:bloomflutterapp/screens/buyer/review_tile.dart';
import 'package:bloomflutterapp/screens/stock/stock_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewTypeList extends StatefulWidget {
  final String supplier;
  ReviewTypeList({this.supplier});
  @override
  _ReviewTypeList createState() => _ReviewTypeList();
}

class _ReviewTypeList extends State<ReviewTypeList> {
  @override
  Widget build(BuildContext context) {
    final reviews = Provider.of<List<Review>>(context) ?? [];
    List<Review> filteredReviews = reviews.where((Review r) {
      if (widget.supplier == null) {
        return r.uid != null;
      } else {
        return r.fullName.contains(widget.supplier);
      }
    }).toList();

    return ListView.builder(
      itemCount: filteredReviews.length,
      itemBuilder: (context, index) {
        return ReviewTile(review: filteredReviews[index])
            //Navigator.push(context,  MaterialPageRoute(builder: (context) => ProductDetails())))
            ;
      },
    );
  }
}
