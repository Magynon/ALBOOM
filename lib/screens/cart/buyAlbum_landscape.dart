import 'dart:ui';
import 'package:app/objects/album.dart';
import 'package:app/actions/openURL.dart';
import 'package:app/objects/cartItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuyScreenLandscape extends StatefulWidget {
  final Album albumObj;
  const BuyScreenLandscape({Key? key, required this.albumObj})
      : super(key: key);

  @override
  _BuyScreenLandscapeState createState() => _BuyScreenLandscapeState();
}

class _BuyScreenLandscapeState extends State<BuyScreenLandscape> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    double localHeight = MediaQuery.of(context).size.height * 0.6;
    // final cartItemList = Provider.of<ListOfCartItems>(context);
    final showLogin = Provider.of<ListOfCartItems>(context);

    return Stack(children: [
      Positioned(
        bottom: 0,
        child: Dialog(
          insetPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          elevation: 16,
          backgroundColor: Colors.transparent,
          child: Container(
            height: localHeight,
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
    double localHeight = MediaQuery.of(context).size.height * 0.6;
    double screenWidth = MediaQuery.of(context).size.width;

    double albumArtHeight = localHeight * 0.35;
    double albumDetailsHeight = localHeight * 0.2;

    return Wrap(
      direction: Axis.horizontal,
      children: [
        Container(
          // color: Colors.blue,
          height: localHeight,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.03),
                child: Container(
                  width: screenWidth * 0.3,
                  height: localHeight * 0.8,
                  alignment: Alignment.centerRight,
                  // color: Colors.blueGrey,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      widget.albumObj.coverArt,
                    ),
                  ),
                ),
              ),
              Container(
                // color: Colors.red,
                width: screenWidth * 0.33,
                height: localHeight * 0.8,
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: localHeight * 0.15,
                        left: screenWidth * 0.03,
                        right: screenWidth * 0.03,
                      ),
                      child: Text(
                        widget.albumObj.name,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: localHeight * 0.15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(albumArtHeight * 0.06),
                      child: Text(
                        widget.albumObj.band,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: localHeight * 0.05,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      // color: Colors.green,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              top: albumDetailsHeight * 0.1,
                              bottom: albumDetailsHeight * 0.1,
                            ),
                            height: albumDetailsHeight,
                            child: Column(
                              children: [
                                Text(
                                  'Liked: ' +
                                      (widget.albumObj.like ? 'Yes' : 'No') +
                                      ' | Year: ' +
                                      widget.albumObj.year,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: albumDetailsHeight * 0.3,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  'Label: ' + widget.albumObj.label,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: albumDetailsHeight * 0.3,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // color: Colors.amber,
                // height: buttonsHeight,
                width: screenWidth * 0.33,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: localHeight * 0.15,
                        bottom: localHeight * 0.03,
                      ),
                      child: previewButton(localHeight * 0.25),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        plusButton(localHeight * 0.25),
                        cartButton(localHeight * 0.25),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget cartButton(double buttonsHeight) {
    CartItem item = CartItem(widget.albumObj, quantity);
    double localHeight = buttonsHeight * 0.6;

    final cartItemList = Provider.of<ListOfCartItems>(context);

    void addItem(CartItem item) {
      cartItemList.addItemToList(item);
      Navigator.pop(context);
    }

    return Container(
      // color: Colors.amber,
      height: buttonsHeight * 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Checkout: ',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w100,
              fontSize: buttonsHeight * 0.15,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            // color: Colors.pink,
            height: localHeight * 1.25,
            width: localHeight * 1.25,

            // BUTTON LAYERS
            child: Stack(
              children: [
                // button icon
                Container(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: localHeight,
                    height: localHeight,
                    child: FloatingActionButton(
                      child: Icon(Icons.shopping_cart, size: localHeight * 0.5),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      onPressed: () => {addItem(item)},
                    ),
                  ),
                ),

                // button background
                Container(
                  alignment: Alignment.center,
                  width: localHeight * 0.4,
                  height: localHeight * 0.4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Text(
                    quantity.toString(),
                    style: TextStyle(
                      fontSize: localHeight * 0.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget previewButton(double localHeight) {
    return Container(
      // color: Colors.green,
      height: localHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.white),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: localHeight * 0.2),
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                ),
                onPressed: () => openLink(widget.albumObj.url),
                child: Text(
                  'Preview',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: localHeight * 0.2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget plusButton(double buttonsHeight) {
    double localHeight = buttonsHeight * 0.6;
    return Container(
      height: localHeight,
      width: localHeight,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1.0, color: const Color(0xFFFFFFFF)),
        // color: Colors.blue,
      ),
      child: IconButton(
        icon: Icon(
          Icons.plus_one,
          size: localHeight * 0.4,
          color: Colors.white,
        ),
        padding: EdgeInsets.all(0),
        onPressed: () {
          setState(() {
            quantity += 1;
          });
        },
      ),
    );
  }
}
