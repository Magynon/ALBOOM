import 'package:app/screens/home/albumList.dart';
import 'package:app/screens/home/latestNews.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              // album section
              Wrap(
                children: [
                  Column(
                    children: [
                      // small title
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(40.0, 0.0, 0.0, 15.0),
                        child: Row(
                          children: [
                            Text(
                              'Most liked this month!',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // album list
                      AlbumList(),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Divider(color: Colors.white30),
              ),

              // news section
              Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 10.0, 0.0, 25.0),
                child: Row(
                  children: [
                    Text(
                      'Hear the latest news!'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),

              // latest news list
              Row(
                children: [
                  LatestNews(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
