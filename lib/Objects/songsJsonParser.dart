class AlbumJSON {
  late List<News> news;

  AlbumJSON(this.news);

  AlbumJSON.fromJson(Map<String, dynamic> json) {
    if (json['news'] != null) {
      List<News> news = [];
      json['news'].forEach((v) {
        news.add(new News.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.news != null) {
      data['news'] = this.news.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class News {
  late String thumbnail;
  late String url;
  late String headline;

  News(this.thumbnail, this.url, this.headline);

  News.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    url = json['url'];
    headline = json['headline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumbnail'] = this.thumbnail;
    data['url'] = this.url;
    data['headline'] = this.headline;
    return data;
  }
}
