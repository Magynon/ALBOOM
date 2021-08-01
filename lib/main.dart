// @dart=2.9
import 'package:app/objects/album.dart';
import 'package:app/screens/auth/authBool.dart';
import 'package:app/screens/auth/authenticate.dart';
import 'package:app/objects/cartItem.dart';
import 'package:app/screens/loading/loadingObj.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'objects/homeScreenLists.dart';

void main() => runApp(
      AppProviders(
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALBOOM',
      debugShowCheckedModeBanner: false,
      home: Authenticate(),
      // home: CurrentScreen(),
      theme: ThemeData(
        primaryColor: Colors.grey[900],
        accentColor: Colors.lightGreen[800],
        scaffoldBackgroundColor: Colors.grey[900],
      ),
    );
  }
}

class AppProviders extends StatelessWidget {
  final Widget child;

  AppProviders({this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ListOfCartItems>(
            create: (context) => ListOfCartItems()),
        ChangeNotifierProvider<ChangeAuth>(create: (context) => ChangeAuth()),
        ChangeNotifierProvider<LoadingVar>(create: (context) => LoadingVar()),
        ChangeNotifierProvider<AlbumItems>(create: (context) => AlbumItems()),
        ChangeNotifierProvider<NewsItems>(create: (context) => NewsItems()),
        ChangeNotifierProvider<MostLiked>(create: (context) => MostLiked()),
        ChangeNotifierProvider<ListOfAlbums>(
            create: (context) => ListOfAlbums()),
      ],
      child: child,
    );
  }
}
