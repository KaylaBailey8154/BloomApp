import 'package:bloomflutterapp/models/favorite.dart';
import 'package:bloomflutterapp/models/review.dart';
import 'package:bloomflutterapp/models/stock.dart';
import 'package:bloomflutterapp/screens/buyer/favorite_list.dart';
import 'package:bloomflutterapp/screens/buyer/review_list.dart';
import 'package:bloomflutterapp/screens/stock/stock_list.dart';
import 'package:bloomflutterapp/services/auth.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_review.dart';


class ViewAllFavorites extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Favorite>>.value(
      value: DatabaseService().allFavorites,
      child: Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Container(height: 550, width: 400, child: FavoritesList())
        ),
      ),
    );
  }
}