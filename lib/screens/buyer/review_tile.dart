import 'package:bloomflutterapp/models/review.dart';
import 'package:bloomflutterapp/models/stock.dart';
import 'package:bloomflutterapp/models/supplier.dart';
import 'package:bloomflutterapp/screens/buyer/product_details.dart';
import 'package:bloomflutterapp/screens/buyer/supplier_details.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReviewTile extends StatelessWidget {
  final Review review;
  ReviewTile({this.review});

  @override
  Widget build(BuildContext context) {
    String fullName = review.fullName;
    String dateAdded = review.dateAdded;
    int rating = review.rating;
    String reviews = review.reviews;

    return Padding(
      padding: EdgeInsets.only(top: 8),
        child: Container(
          height: 130,
          width: 50,
          child: Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(30, 6, 20, 0),
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$fullName',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '$dateAdded',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        color: Colors.orange,
                      );
                    }),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    '$reviews',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
            ),
          ),
        );
  }
}
