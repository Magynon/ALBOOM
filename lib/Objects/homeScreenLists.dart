import 'package:app/objects/songsJsonParser.dart';
import 'package:flutter/cupertino.dart';

class AlbumItems with ChangeNotifier {
  List albumItems = [];

  addList(List list) {
    this.albumItems = list;
    notifyListeners();
  }
}

class NewsItems with ChangeNotifier {
  List newsItems = [];

  addList(List list) {
    this.newsItems = list;
    notifyListeners();
  }
}

class MostLiked with ChangeNotifier {
  List mostLiked = [];

  addList(List list) {
    this.mostLiked = list;
    notifyListeners();
  }
}
