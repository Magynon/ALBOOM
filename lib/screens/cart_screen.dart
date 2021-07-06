import 'package:app/Objects/cartItem.dart';
import 'package:app/components/bottomBar.dart';
import 'package:app/components/topBarHome.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final itemList;
  const CartScreen({Key? key, required this.itemList}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
