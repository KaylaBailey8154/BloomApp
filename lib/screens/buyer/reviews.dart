
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Reviews extends StatefulWidget {
  @override
  _ReviewsState createState() => _ReviewsState();
}
class _ReviewsState extends State<Reviews>{

  int _stars = 0;

  Widget _buildStar(int starCount) {
    return InkWell(
      child: Icon(
        Icons.star,
        // size: 30.0,
        color: _stars >= starCount ? Colors.orange : Colors.grey,
      ),
      onTap: () {
        setState(() {
          _stars = starCount;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
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
                      onPressed: () {
                        Navigator.of(context).pop(_stars);
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
      ],
    );
  }


}