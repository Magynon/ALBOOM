// @dart=2.9
import 'package:app/screens/auth/authBool.dart';
import 'package:app/screens/auth/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var showLogin = ChangeAuth();
    return MaterialApp(
      title: 'Music player',
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider<ChangeAuth>(
          create: (context) => ChangeAuth(), child: Authenticate()),
      theme: ThemeData(
        primaryColor: Colors.grey[900],
        accentColor: Colors.lightGreen[800],
        scaffoldBackgroundColor: Colors.grey[900],
      ),
    );
  }
}
