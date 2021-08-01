import 'dart:math';

import 'package:app/objects/album.dart';
import 'package:app/objects/homeScreenLists.dart';
import 'package:app/screens/loading/loadingObj.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void albumLoader(mostLiked) {
    Random rnd;
    int numberOfAlbums = mostLiked.mostLiked.length;
    int min = 5, max = 50, r;
    String prefix =
        "https://firebasestorage.googleapis.com/v0/b/alboom-a2b32.appspot.com/o";
    var albumList = Provider.of<ListOfAlbums>(context, listen: false);

    for (int i = 0; i < numberOfAlbums; i++) {
      rnd = new Random();
      r = min + rnd.nextInt(max - min);
      var album = Album(
        name: mostLiked.mostLiked[i]["name"],
        band: mostLiked.mostLiked[i]["band"],
        coverArt: prefix + mostLiked.mostLiked[i]["thumbnail"],
        like: false,
        url: mostLiked.mostLiked[i]["url"],
        year: mostLiked.mostLiked[i]["year"],
        label: mostLiked.mostLiked[i]["label"],
        price: r,
      );
      albumList.addAlbumToList(album);
    }
  }

  // Fetch content from the json file
  Future<void> readJson() async {
    final response = await http.get(Uri.parse("https://alboom-a2b32.web.app/"));
    var loading = Provider.of<LoadingVar>(context, listen: false);
    var albumItems = Provider.of<AlbumItems>(context, listen: false);
    var newsItems = Provider.of<NewsItems>(context, listen: false);
    var mostLiked = Provider.of<MostLiked>(context, listen: false);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (this.mounted) {
        setState(() {
          albumItems.addList(data["albums"]);
          newsItems.addList(data["news"]);
          mostLiked.addList(data["mostLiked"]);
        });
      }
      albumLoader(mostLiked);
      loading.toggle();
    } else {
      print("failed to load");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    readJson();
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitChasingDots(
              color: Colors.green,
              size: 50.0,
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: screenWidth < screenHeight
                      ? screenWidth * 0.1
                      : screenHeight * 0.1),
              child: Text(
                "Have a cookie while I deliver the goods!",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: screenWidth < screenHeight
                      ? screenWidth * 0.03
                      : screenHeight * 0.03,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
