import 'dart:ui';

import 'package:app/Objects/album.dart';
import 'package:app/Objects/cartItem.dart';
import 'package:app/actions/openURL.dart';
import 'package:app/screens/cart_screen.dart';
import 'package:flutter/material.dart';

class BuyScreen extends StatefulWidget {
  final Album albumObj;
  const BuyScreen({Key? key, required this.albumObj}) : super(key: key);

  @override
  _BuyScreenState createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  int quantity = 0;
  final itemList = ListOfCartItems();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        bottom: 0,
        child: Dialog(
          insetPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          elevation: 16,
          backgroundColor: Colors.transparent,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                bgImg(),
                contentOverlay(),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  Widget bgImg() {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(),
        ),
        Expanded(
          flex: 8,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60),
                topRight: Radius.circular(60),
              ),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                  child: Image.asset(
                    widget.albumObj.coverArt,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
                    child: Container(
                      color: Colors.black.withOpacity(0.8),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget contentOverlay() {
    return Wrap(
      direction: Axis.horizontal,
      children: [
        Container(
          height: 300,
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        widget.albumObj.coverArt,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        widget.albumObj.name,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        widget.albumObj.band,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20.0),
              height: 90,
              child: Column(
                children: [
                  Text(
                    'Liked: ' +
                        (widget.albumObj.like ? 'Yes' : 'No') +
                        ' | Year: ' +
                        widget.albumObj.year,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    'Label: ' + widget.albumObj.label,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            previewButton(),
            plusButton(),
            cartButton(),
          ],
        ),
      ],
    );
  }

  Widget cartButton() {
    CartItem item = CartItem(widget.albumObj, quantity);
    void addItem(CartItem item) {
      itemList.addItemToList(item);
      // for (int i = 0; i < itemList.listOfItems.length; i++) {
      //   print(itemList.listOfItems[i].item.name);
      //   print(itemList.listOfItems[i].quantity);
      // }
    }

    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: 140,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Checkout: ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w100,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                // color: Colors.pink,
                child: Stack(
                  children: [
                    FloatingActionButton(
                      child: Icon(Icons.shopping_cart),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      onPressed: () => {addItem(item)},
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Text(
                        quantity.toString(),
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget previewButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.white),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                ),
                onPressed: () => openLink(widget.albumObj.url),
                child: Text(
                  'Preview',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget plusButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1.0, color: const Color(0xFFFFFFFF)),
      ),
      child: IconButton(
        icon: Icon(
          Icons.plus_one,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            quantity += 1;
          });
        },
      ),
    );
  }
}
