import 'package:app/Objects/cartItem.dart';
import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';

class CartScreen extends StatefulWidget {
  final ListOfCartItems itemList;
  CartScreen({Key? key, required this.itemList}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < widget.itemList.listOfItems.length; i++) {
      print(widget.itemList.listOfItems[i].item.name);
      print(widget.itemList.listOfItems[i].quantity);
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Container(
                color: Colors.white,
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: previewButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget previewButton() {
    const double localHeight = 60;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: localHeight,
          decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: localHeight / 6),
            child: TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent),
              ),
              onPressed: () => {},
              child: Text(
                'Go to Checkout!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: localHeight / 3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
