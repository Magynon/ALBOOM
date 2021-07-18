// @dart=2.9
import 'package:app/screens/current_screen.dart';
import 'package:app/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music player',
      debugShowCheckedModeBanner: false,
      // home: CurrentScreen(),
      home: LoginScreen(),
      theme: ThemeData(
        primaryColor: Colors.grey[900],
        accentColor: Colors.lightGreen[800],
        scaffoldBackgroundColor: Colors.grey[900],
      ),
    );
  }
}
