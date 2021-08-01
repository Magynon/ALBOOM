import 'dart:ui';
import 'package:app/objects/album.dart';
import 'package:app/actions/openURL.dart';
import 'package:app/objects/cartItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuyScreenPortrait extends StatefulWidget {
  late int index;
  BuyScreenPortrait({Key? key, required this.index}) : super(key: key);

  @override
  _BuyScreenPortraitState createState() => _BuyScreenPortraitState();
}

class _BuyScreenPortraitState extends State<BuyScreenPortrait> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    double localHeight = MediaQuery.of(context).size.height * 0.6;
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
    var albumList = Provider.of<ListOfAlbums>(context);
    var albumObj = albumList.listOfAlbums.elementAt(widget.index);
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
                  child: Image.network(
                    albumObj.coverArt,
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
    double localHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double albumArtHeight = localHeight * 0.35;
    double albumDetailsHeight = localHeight * 0.105;
    double buttonsHeight = localHeight * 0.145;

    var albumList = Provider.of<ListOfAlbums>(context);
    var albumObj = albumList.listOfAlbums.elementAt(widget.index);

    return Wrap(
      direction: Axis.horizontal,
      children: [
        Container(
          // color: Colors.blue,
          height: localHeight * 0.35,
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        albumObj.coverArt,
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
                      padding: EdgeInsets.only(top: albumArtHeight * 0.05),
                      child: Text(
                        albumObj.name,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: albumArtHeight * 0.1,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(albumArtHeight * 0.02),
                      child: Text(
                        albumObj.band,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: albumArtHeight * 0.05,
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
        Container(
          // color: Colors.green,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: albumDetailsHeight * 0.22,
                  bottom: albumDetailsHeight * 0.20,
                ),
                height: albumDetailsHeight,
                child: Column(
                  children: [
                    Text(
                      'Liked: ' +
                          (albumObj.like ? 'Yes' : 'No') +
                          ' | Year: ' +
                          albumObj.year,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: albumDetailsHeight * 0.22,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      'Label: ' + albumObj.label,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: albumDetailsHeight * 0.22,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          // color: Colors.red,
          height: buttonsHeight,
          padding: EdgeInsets.only(
              left: screenWidth * 0.04, right: screenWidth * 0.04),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              previewButton(buttonsHeight),
              plusButton(buttonsHeight),
              cartButton(buttonsHeight),
            ],
          ),
        ),
      ],
    );
  }

  Widget cartButton(double buttonsHeight) {
    var albumList = Provider.of<ListOfAlbums>(context);
    var albumObj = albumList.listOfAlbums.elementAt(widget.index);

    CartItem item = CartItem(albumObj, quantity);
    double localHeight = buttonsHeight * 0.4;

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

  Widget previewButton(double buttonsHeight) {
    double localHeight = buttonsHeight * 0.4;

    var albumList = Provider.of<ListOfAlbums>(context);
    var albumObj = albumList.listOfAlbums.elementAt(widget.index);

    return Container(
      // color: Colors.green,
      child: Row(
        children: [
          Container(
            height: localHeight,
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.white),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.all(localHeight * 0.1),
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                ),
                onPressed: () => openLink(albumObj.url),
                child: Text(
                  'Preview',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: localHeight * 0.3,
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
    double localHeight = buttonsHeight * 0.4;
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
