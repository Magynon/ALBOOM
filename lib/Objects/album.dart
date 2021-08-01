import 'package:flutter/cupertino.dart';

class Album {
  late String name, band, coverArt, url, year, label;
  late int price;
  late bool like;

  Album(
      {required this.name,
      required this.band,
      required this.coverArt,
      required this.like,
      required this.url,
      required this.year,
      required this.label,
      required this.price});

  likeAlbum() {
    this.like = true;
    print('liked');
  }

  dislikeAlbum() {
    this.like = false;
    print('disliked');
  }

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        name: json["name"],
        band: json["band"],
        coverArt: json["thumbnail"],
        label: json["label"],
        like: false,
        price: 0,
        url: json["url"],
        year: json["year"]);
  }
}

class ListOfAlbums with ChangeNotifier {
  late List<Album> listOfAlbums;
  late int numberOfAlbums;

  ListOfAlbums() {
    listOfAlbums = [];
    numberOfAlbums = 0;
  }

  addAlbumToList(Album album) {
    listOfAlbums.add(album);
    numberOfAlbums += 1;
    notifyListeners();
  }
}
