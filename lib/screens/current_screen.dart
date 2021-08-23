import 'dart:async';

import 'package:app/components/topBar.dart';
import 'package:app/objects/cartItem.dart';
import 'package:app/screens/noInternet/noInternet_screen.dart';
import 'package:app/screens/search/search_screen.dart';
import 'package:app/screens/settings/settings_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'cart/cart_screen.dart';
import 'home/home_screen.dart';

class CurrentScreen extends StatefulWidget {
  const CurrentScreen({Key? key}) : super(key: key);

  @override
  _CurrentScreenState createState() => _CurrentScreenState();
}

class _CurrentScreenState extends State<CurrentScreen> {
  int _selectedIndex = 0;
  final cartItemList = ListOfCartItems();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      HomeScreen(),
      SearchScreen(),
      CartScreen(),
      SettingsScreen(),
    ];

    List<String> _appBarOptions = [
      'Home',
      'Search',
      'Cart',
      'Settings',
    ];

    return Scaffold(
      appBar: VariableAppBar(_appBarOptions.elementAt(_selectedIndex)),
      body: StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder:
            (BuildContext context, AsyncSnapshot<ConnectivityResult> snapshot) {
          if (snapshot.hasData && snapshot.data != ConnectivityResult.none) {
            return _widgetOptions.elementAt(_selectedIndex);
          } else {
            return NoInternet();
          }
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.grey[800]?.withOpacity(0.9),
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.store),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Settings',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.lightGreen[400],
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
