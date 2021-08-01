import 'package:app/Objects/newsActions.dart';
import 'package:app/objects/homeScreenLists.dart';
import 'package:flutter/material.dart';
import 'package:app/actions/openURL.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class LatestNews extends StatefulWidget {
  const LatestNews({Key? key}) : super(key: key);

  @override
  _LatestNewsState createState() => _LatestNewsState();
}

class _LatestNewsState extends State<LatestNews> {
  String prefix =
      "https://firebasestorage.googleapis.com/v0/b/alboom-a2b32.appspot.com/o";

  @override
  Widget build(BuildContext context) {
    var newsItemsProvider = Provider.of<NewsItems>(context);
    return Expanded(
      child: SizedBox(
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 10),
            shrinkWrap: true,
            itemCount: newsItemsProvider.newsItems.length > 10
                ? 10
                : newsItemsProvider.newsItems.length,
            itemBuilder: (BuildContext context, int index) {
              return _listElement(index);
            }),
      ),
    );
  }

  Widget _listElement(int index) {
    var newsItemsProvider = Provider.of<NewsItems>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 20.0),
          // for border radius
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Stack(children: [
              // thumbnail
              GestureDetector(
                onTap: () =>
                    openLink(newsItemsProvider.newsItems[index]["url"]),
                child: Image.network(
                  prefix + newsItemsProvider.newsItems[index]["thumbnail"],
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              // headline
              Positioned(
                bottom: 0.0,
                child: headline(context, index),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget headline(BuildContext context, int index) {
    final List<NewsActions> choices = [
      NewsActions('Share', Icons.share),
      NewsActions('Hide', Icons.visibility),
    ];
    double localWidth = MediaQuery.of(context).size.width - 60;
    var newsItemsProvider = Provider.of<NewsItems>(context);
    return Container(
      height: 40,
      width: localWidth,
      color: Colors.lightGreen[900]?.withOpacity(0.8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: localWidth - 50,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                // headline text
                child: Text(
                  newsItemsProvider.newsItems[index]["headline"],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          headlineActions(choices, index),
        ],
      ),
    );
  }

  Widget headlineActions(List<NewsActions> choices, int index) {
    var newsItemsProvider = Provider.of<NewsItems>(context);
    return Container(
      child: PopupMenuButton<NewsActions>(
        onSelected: (NewsActions choice) {
          if (choice.text == 'Share') {
            final RenderBox box = context.findRenderObject() as RenderBox;
            Share.share(newsItemsProvider.newsItems[index]["url"],
                sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
          } else {
            setState(() {
              newsItemsProvider.newsItems.removeAt(index);
              print(newsItemsProvider.newsItems);
            });
          }
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        icon: Icon(Icons.more_vert, color: Colors.white),
        itemBuilder: (BuildContext context) {
          return choices.map((NewsActions choice) {
            return PopupMenuItem(
              value: choice,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(choice.icon, size: 20),
                  Text(choice.text),
                ],
              ),
            );
          }).toList();
        },
      ),
    );
  }
}
