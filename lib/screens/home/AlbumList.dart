import 'dart:math';
import 'package:app/objects/album.dart';
import 'package:app/objects/homeScreenLists.dart';
import 'package:app/screens/cart/buyAlbum_landscape.dart';
import 'package:app/screens/cart/buyAlbum_portrait.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlbumList extends StatefulWidget {
  AlbumList({Key? key}) : super(key: key);

  @override
  _AlbumListState createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var albumList = Provider.of<ListOfAlbums>(context);
    var numberOfAlbums = albumList.listOfAlbums.length;
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
                    child: _likeArea(index),
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
    var albumList = Provider.of<ListOfAlbums>(context);
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (builder) {
            return OrientationBuilder(
              builder: (context, orientation) {
                if (orientation == Orientation.portrait)
                  return BuyScreenPortrait(index: index);
                else
                  return BuyScreenLandscape(index: index);
              },
            );
          },
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.network(
          albumList.listOfAlbums.elementAt(index).coverArt,
          width: 150.0,
          height: 150.0,
        ),
      ),
    );
  }

  Widget _likeArea(int index) {
    var albumList = Provider.of<ListOfAlbums>(context);
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
