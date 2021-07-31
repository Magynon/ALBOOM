import 'package:app/screens/home/albumList.dart';
import 'package:app/screens/home/latestNews.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List albumItems = [];
  List newsItems = [];
  List mostLiked = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final response =
        await http.get(Uri.parse("https://alboom-database.web.app/"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (this.mounted) {
        setState(() {
          newsItems = data["news"];
          albumItems = data["albums"];
          mostLiked = data["mostLiked"];
        });
      }
    } else {
      print("failed to load");
    }
  }

  @override
  Widget build(BuildContext context) {
    readJson();
    return Scaffold(
      //
      body: Stack(
        children: [
          // proper body
          ListView(
            // mainAxisSize: MainAxisSize.min,
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

                      AlbumList(mostLiked: mostLiked),
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
                  LatestNews(newsItems: newsItems),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
