import 'dart:convert';
import 'dart:math';
import 'package:app/Objects/album.dart';
import 'package:app/Objects/cartItem.dart';
import 'package:app/screens/cart/buyAlbum_landscape.dart';
import 'package:app/screens/cart/buyAlbum_portrait.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;

class AlbumList extends StatefulWidget {
  const AlbumList({Key? key}) : super(key: key);

  @override
  _AlbumListState createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  int index = 0;
  List albumItems = [];
  List newsItems = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('database/db.json');
    final data = await json.decode(response);
    setState(() {
      newsItems = data["news"];
      albumItems = data["albums"];
    });
  }

  final albumList = ListOfAlbums();

  @override
  Widget build(BuildContext context) {
    Random rnd;
    int numberOfAlbums = albumItems.length;
    int min = 5, max = 50, r;

    readJson();

    for (int i = 0; i < numberOfAlbums; i++) {
      rnd = new Random();
      r = min + rnd.nextInt(max - min);
      var album = Album(
        name: albumItems[i]["name"],
        band: albumItems[i]["band"],
        coverArt: albumItems[i]["thumbnail"],
        like: false,
        url: albumItems[i]["url"],
        year: albumItems[i]["year"],
        label: albumItems[i]["label"],
        price: r,
      );
      albumList.addAlbumToList(album);
    }

    // main album list builder
    return Container(
      child: SizedBox(
        height: 200.0,
        child: ListView.builder(
          padding: EdgeInsets.only(left: 20.0),
          scrollDirection: Axis.horizontal,
          itemCount: numberOfAlbums,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: Column(
                children: [
                  _albumArt(index),
                  Container(
                    width: 150,
                    child: _likeArea(albumList, index),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _albumArt(int index) {
    final itemList = Provider.of<ListOfCartItems>(context);

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (builder) {
            return OrientationBuilder(
              builder: (context, orientation) {
                if (orientation == Orientation.portrait)
                  return BuyScreenPortrait(
                    albumObj: albumList.listOfAlbums.elementAt(index),
                    itemList: itemList,
                  );
                else
                  return BuyScreenLandscape(
                    albumObj: albumList.listOfAlbums.elementAt(index),
                    itemList: itemList,
                  );
              },
            );
          },
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.asset(
          albumList.listOfAlbums.elementAt(index).coverArt,
          width: 150.0,
          height: 150.0,
        ),
      ),
    );
  }

  Widget _likeArea(ListOfAlbums albumList, int index) {
    final alreadyLiked = albumList.listOfAlbums.elementAt(index).like;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // artist title
        Text(
          albumList.listOfAlbums.elementAt(index).band,
          style: TextStyle(
            color: Colors.grey[300],
            fontSize: 10,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.left,
        ),
        // like icon
        Container(
          width: 20,
          child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(alreadyLiked ? Icons.favorite : Icons.favorite_border,
                  size: 20),
              color: alreadyLiked ? Colors.pink : Colors.white.withOpacity(0.5),
              onPressed: () {
                setState(() {
                  if (albumList.listOfAlbums.elementAt(index).like) {
                    albumList.listOfAlbums.elementAt(index).dislikeAlbum();
                  } else {
                    albumList.listOfAlbums.elementAt(index).likeAlbum();
                  }
                });
              }),
        )
      ],
    );
  }
}
