import 'package:app/objects/album.dart';
import 'package:app/screens/auth/authenticate.dart';
import 'package:app/objects/cartItem.dart';
import 'package:app/screens/loading/loadingObj.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'actions/auth.dart';
import 'objects/homeScreenLists.dart';
import 'package:firebase_core/firebase_core.dart';

import 'objects/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    AppProviders(
      child: MyApp(),
    ),
  );
}

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

  AppProviders({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<MyUser?>.value(
            catchError: (_, __) => null,
            value: AuthService().user,
            initialData: null),
        ChangeNotifierProvider<ListOfCartItems>(
            create: (context) => ListOfCartItems()),
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
