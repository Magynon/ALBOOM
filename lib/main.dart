// @dart=2.9
import 'package:app/screens/cart_screen.dart';
import 'package:app/screens/current_screen.dart';
import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Music player',
        debugShowCheckedModeBanner: false,
        home: CurrentScreen(),
        routes: <String, WidgetBuilder>{
          '/Home': (context) => HomeScreen(),
          '/Cart': (context) => CartScreen(itemList: null),
        },
        theme: ThemeData(
          primaryColor: Colors.grey[900],
          accentColor: Colors.lightGreen[800],
          scaffoldBackgroundColor: Colors.grey[900],
        ));
  }
}
