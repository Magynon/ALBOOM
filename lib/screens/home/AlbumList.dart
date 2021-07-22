import 'dart:math';
import 'package:app/objects/album.dart';
import 'package:app/screens/cart/buyAlbum_landscape.dart';
import 'package:app/screens/cart/buyAlbum_portrait.dart';
import 'package:flutter/material.dart';

class AlbumList extends StatefulWidget {
  final List mostLiked;

  AlbumList({Key? key, required this.mostLiked}) : super(key: key);

  @override
  _AlbumListState createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  int index = 0;

  final albumList = ListOfAlbums();

  @override
  Widget build(BuildContext context) {
    Random rnd;
    int numberOfAlbums = widget.mostLiked.length;
    int min = 5, max = 50, r;

    for (int i = 0; i < numberOfAlbums; i++) {
      rnd = new Random();
      r = min + rnd.nextInt(max - min);
      var album = Album(
        name: widget.mostLiked[i]["name"],
        band: widget.mostLiked[i]["band"],
        coverArt: widget.mostLiked[i]["thumbnail"],
        like: false,
        url: widget.mostLiked[i]["url"],
        year: widget.mostLiked[i]["year"],
        label: widget.mostLiked[i]["label"],
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
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (builder) {
            return OrientationBuilder(
              builder: (context, orientation) {
                if (orientation == Orientation.portrait)
                  return BuyScreenPortrait(
                      albumObj: albumList.listOfAlbums.elementAt(index));
                else
                  return BuyScreenLandscape(
                      albumObj: albumList.listOfAlbums.elementAt(index));
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
