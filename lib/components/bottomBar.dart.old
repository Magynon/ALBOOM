import 'package:app/screens/cart_screen.dart';
import 'package:flutter/material.dart';

class MyBottomAppBar extends StatefulWidget {
  const MyBottomAppBar({Key? key}) : super(key: key);

  @override
  _MyBottomAppBarState createState() => _MyBottomAppBarState();
}

class _MyBottomAppBarState extends State<MyBottomAppBar> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // home button
                  IconButton(
                    color: counter == 0 ? Colors.lightGreen[800] : Colors.black,
                    onPressed: () {
                      setState(() {
                        counter = 0;
                      });
                    },
                    icon: Icon(
                      Icons.home,
                      size: 35,
                    ),
                    splashRadius: 1,
                  ),
                  // search button
                  IconButton(
                    color: counter == 1 ? Colors.lightGreen[800] : Colors.black,
                    icon: Icon(
                      Icons.search,
                      size: 35,
                    ),
                    onPressed: () {
                      setState(() {
                        counter = 1;
                      });
                    },
                    splashRadius: 1,
                  ),
                  // store button
                  IconButton(
                    color: counter == 2 ? Colors.lightGreen[800] : Colors.black,
                    onPressed: () {
                      setState(() {
                        counter = 2;
                      });
                      Navigator.pushNamed(context, '/Cart');
                    },
                    icon: Icon(
                      Icons.store,
                      size: 35,
                    ),
                    splashRadius: 1,
                  ),
                  // person button
                  IconButton(
                    color: counter == 3 ? Colors.lightGreen[800] : Colors.black,
                    onPressed: () {
                      setState(() {
                        counter = 3;
                      });
                    },
                    icon: Icon(
                      Icons.person,
                      size: 35,
                    ),
                    splashRadius: 1,
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.grey[800]?.withOpacity(0.9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
