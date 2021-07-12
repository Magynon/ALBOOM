class Album {
  late String name, band, coverArt, url, year, label;
  late int price;
  late bool like;

  Album(this.name, this.band, this.coverArt, this.like, this.url, this.year,
      this.label, this.price);

  likeAlbum() {
    this.like = true;
    print('liked');
  }

  dislikeAlbum() {
    this.like = false;
    print('disliked');
  }
}

class ListOfAlbums {
  late List<Album> listOfAlbums;
  late int numberOfAlbums;

  ListOfAlbums() {
    listOfAlbums = [];
    numberOfAlbums = 0;
  }

  addAlbumToList(Album album) {
    listOfAlbums.add(album);
    numberOfAlbums += 1;
  }
}
