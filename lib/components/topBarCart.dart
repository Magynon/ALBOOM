import 'package:flutter/material.dart';

class CartAppBar extends StatelessWidget with PreferredSizeWidget {
  final double appBarHeight = 70.0;

  @override
  get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Cart',
                  style: TextStyle(
                    color: Colors.lightGreen[600],
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color:
            ThemeData.dark().appBarTheme.color ?? ThemeData.dark().primaryColor,
      ),
    );
  }
}
