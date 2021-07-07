import 'package:app/Objects/cartItem.dart';
import 'package:app/components/topBarCart.dart';
import 'package:app/components/topBarHome.dart';
import 'package:app/components/topBarSettings.dart';
import 'package:app/screens/cart_screen.dart';
import 'package:app/screens/settings_screen.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class CurrentScreen extends StatefulWidget {
  const CurrentScreen({Key? key}) : super(key: key);

  @override
  _CurrentScreenState createState() => _CurrentScreenState();
}

class _CurrentScreenState extends State<CurrentScreen> {
  int _selectedIndex = 0;
  final itemList = ListOfCartItems();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      HomeScreen(itemList: itemList),
      CartScreen(itemList: itemList),
      SettingsScreen(),
    ];

    List<PreferredSizeWidget?> _appBarOptions = <PreferredSizeWidget?>[
      HomeAppBar(),
      CartAppBar(),
      SettingsAppBar(),
    ];
    return Scaffold(
      //
      appBar: _appBarOptions.elementAt(_selectedIndex),
      //
      body: _widgetOptions.elementAt(_selectedIndex),
      //
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
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
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
            selectedItemColor: Colors.lightGreen[800],
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
