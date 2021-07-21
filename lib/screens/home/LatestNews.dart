import 'package:app/Objects/newsActions.dart';
import 'package:flutter/material.dart';
import 'package:app/actions/openURL.dart';
import 'package:share/share.dart';

class LatestNews extends StatefulWidget {
  const LatestNews({Key? key}) : super(key: key);

  @override
  _LatestNewsState createState() => _LatestNewsState();
}

class _LatestNewsState extends State<LatestNews> {
  List thumbnails = [
    'assets/images/news/1.jpeg',
    'assets/images/news/2.jpg',
    'assets/images/news/3.jpg',
    'assets/images/news/4.jpg',
  ];

  List headlines = [
    'Guns N\' Roses on starting tour in 2022 in North America',
    'Swedish guitarist Yngwie Malmsteen on how he met Leo Fender',
    'Ozzy Osbourne confessing to being sober for over 20 days',
    'Def Leppard unite forces with guitarist Vivian Campbell',
  ];

  List urls = [
    'https://www.youtube.com/watch?v=Z2QCORi-u0U',
    'https://www.youtube.com/watch?v=F74Tw99qfRg',
    'https://www.youtube.com/watch?v=F89-MOy7Xfg',
    'https://www.youtube.com/watch?v=boMOhT--utg',
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 10),
            shrinkWrap: true,
            itemCount: urls.length > 10 ? 10 : urls.length,
            itemBuilder: (BuildContext context, int index) {
              return _listElement(index);
            }),
      ),
    );
  }

  Widget _listElement(int index) {
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
                onTap: () => openLink(urls[index]),
                child: Image.asset(
                  thumbnails[index],
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              // headline
              Positioned(
                bottom: 0.0,
                child: headline(context, headlines, index),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget headline(BuildContext context, List headlines, int index) {
    final List<NewsActions> choices = [
      NewsActions('Share', Icons.share),
      NewsActions('Hide', Icons.visibility),
    ];
    double localWidth = MediaQuery.of(context).size.width - 60;
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
                  headlines[index],
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
    return Container(
      child: PopupMenuButton<NewsActions>(
        onSelected: (NewsActions choice) {
          if (choice.text == 'Share') {
            final RenderBox box = context.findRenderObject() as RenderBox;
            Share.share(urls[index],
                sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
          } else {
            setState(() {
              thumbnails.removeAt(index);
              urls.removeAt(index);
              headlines.removeAt(index);
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
