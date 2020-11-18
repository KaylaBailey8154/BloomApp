import 'package:bloomflutterapp/models/favorite.dart';
import 'package:bloomflutterapp/models/review.dart';
import 'package:bloomflutterapp/models/stock.dart';
import 'package:bloomflutterapp/screens/buyer/favorite_tile.dart';
import 'package:bloomflutterapp/screens/buyer/review_tile.dart';
import 'package:bloomflutterapp/screens/stock/stock_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesList extends StatefulWidget {
  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoritesList> {
  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<List<Favorite>>(context) ?? [];
    print(favorites.length);
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        return FavoriteTile(favorite: favorites[index]);
      },
    );
  }
}
