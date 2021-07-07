import 'package:app/Objects/album.dart';
import 'package:app/Objects/cartItem.dart';
import 'package:app/screens/buyAlbum.dart';
import 'package:flutter/material.dart';

class AlbumList extends StatefulWidget {
  final ListOfCartItems itemList;
  const AlbumList({Key? key, required this.itemList}) : super(key: key);

  @override
  _AlbumListState createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  int index = 0;

  List albums = [
    'Trilogy',
    'Appetite For Destruction',
    'Van Halen I',
    'Road Games',
    '1987',
  ];
  List thumbnails = [
    'assets/images/albums/1.jpg',
    'assets/images/albums/2.jpeg',
    'assets/images/albums/3.jpg',
    'assets/images/albums/4.jpg',
    'assets/images/albums/5.jpg',
  ];
  List bands = [
    '@yngwiemalmsteen',
    '@guns\'n\'roses',
    '@vanhalen',
    '@allanholdsworth',
    '@whitesnake'
  ];
  List urls = [
    'https://www.youtube.com/watch?v=lOB0TNEBRhA&list=OLAK5uy_lKN3JZIWeYsHYBAZq5lq9ai0yUsoKiYQY',
    'https://www.youtube.com/watch?v=o1tj2zJ2Wvg&list=OLAK5uy_n13hmdsIozcCRyaY4cRDuuviphpfbzPrw',
    'https://www.youtube.com/watch?v=KLRO4W9pNrQ&list=PLP_vXshlStIdUFp9pJ7qffQS8TbwmqVkL',
    'https://www.youtube.com/watch?v=FqizaAJ-rN0',
    'https://www.youtube.com/watch?v=jaEzfy_gHkM&list=PLgLk-j8sdm7avB5pRF59hgM6bfHxs2Xz_',
  ];
  List years = [
    '1986',
    '1987',
    '1978',
    '1983',
    '1987',
  ];
  List labels = [
    'Polydor Records',
    'Geffen Records',
    'Burbank Records',
    'Warner Bros. Records',
    'EMI Records',
  ];

  int numberOfAlbums = 5;
  final albumList = ListOfAlbums();

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < numberOfAlbums; i++) {
      var album = Album(albums[i], bands[i], thumbnails[i], false, urls[i],
          years[i], labels[i]);
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
                  _albumArt(albumList, index),
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

  Widget _albumArt(ListOfAlbums albumList, int index) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (builder) {
            return BuyScreen(
              albumObj: albumList.listOfAlbums.elementAt(index),
              itemList: widget.itemList,
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
