import 'package:app/screens/cart/checkout_screen.dart';
import 'package:app/objects/cartItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void checkoutDialog(BuildContext context) {
  WidgetsBinding.instance!.addPostFrameCallback(
    (_) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutDialog(),
      ),
    ),
  );
}

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height - 70 - 80;
    double screenWidth = MediaQuery.of(context).size.width * 0.9;

    final itemList = Provider.of<ListOfCartItems>(context);

    for (int i = 0; i < itemList.listOfItems.length; i++) {
      print(itemList.listOfItems[i].item.name);
      print(itemList.listOfItems[i].quantity);
      print("total: " + itemList.total.toString());
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
          ),
          child: Column(
            children: [
              // subtitle
              Container(
                // color: Colors.yellow,
                height: screenHeight * 0.08,
                child: subtitle(screenHeight * 0.08, screenWidth),
              ),

              // cart items
              Container(
                height: screenHeight * 0.62,
                // color: Colors.white,
                child: Column(
                  children: [
                    _listOfItems(screenHeight, screenWidth),
                  ],
                ),
              ),

              // final price
              Container(
                height: screenHeight * 0.17,
                // color: Colors.blue,
                child: TotalPrice(
                  sectionHeight: screenHeight * 0.17,
                  screenWidth: screenWidth,
                ),
              ),

              // buttons
              Container(
                height: screenHeight * 0.13,
                // color: Colors.pink,
                child: Center(
                    child: paymentButton(screenHeight * 0.1, screenWidth)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listOfItems(double screenHeight, double screenWidth) {
    final itemList = Provider.of<ListOfCartItems>(context);
    return Expanded(
      child: SizedBox(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: itemList.listOfItems.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.02),
                child: _listElement(index, screenHeight, screenWidth),
              );
            }),
      ),
    );
  }

  Widget _listElement(int index, double screenHeight, double screenWidth) {
    double leftSideWidth = screenWidth * 0.7;
    double imageWidth = leftSideWidth * 0.3;
    double albumDetailsWidth = leftSideWidth * 0.7;
    double rightSideWidth = screenWidth * 0.3;

    final itemList = Provider.of<ListOfCartItems>(context);
    return Container(
      padding: EdgeInsets.only(bottom: screenHeight * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            // color: Colors.blue,
            width: leftSideWidth,
            height: screenHeight * 0.15,
            child: Row(
              children: [
                Container(
                  child: Image.asset(
                    itemList.listOfItems[index].item.coverArt,
                    width: imageWidth,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  // color: Colors.red,
                  alignment: Alignment.centerLeft,
                  width: albumDetailsWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: albumDetailsWidth * 0.9,
                        // color: Colors.green,
                        child: Text(
                          itemList.listOfItems[index].item.name,
                          // "Album namekjhjvjvbjhgjn",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Manrope",
                            fontWeight: FontWeight.normal,
                            fontSize: albumDetailsWidth * 0.1,
                          ),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        // color: Colors.black,
                        width: albumDetailsWidth * 0.9,
                        child: Text(
                          itemList.listOfItems[index].item.band +
                              " " +
                              itemList.listOfItems[index].item.year,
                          // "Band year",
                          style: TextStyle(
                            color: Colors.white54,
                            fontFamily: "Manrope",
                            fontWeight: FontWeight.normal,
                            fontSize: albumDetailsWidth * 0.08,
                          ),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
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
            width: rightSideWidth,
            height: screenHeight * 0.15,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // color: Colors.red,
                  width: rightSideWidth,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        iconSize: rightSideWidth * 0.2,
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            itemList
                                .popItemFromList(itemList.listOfItems[index]);
                          });
                        },
                        icon: Icon(Icons.remove_circle_outline,
                            color: Colors.white60),
                      ),
                      Text(
                        itemList.listOfItems[index].quantity.toString(),
                        style: TextStyle(
                          color: Colors.white54,
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.normal,
                          fontSize: rightSideWidth * 0.2,
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: rightSideWidth * 0.2,
                        onPressed: () {
                          setState(() {
                            itemList.addItemToList(itemList.listOfItems[index]);
                          });
                        },
                        icon: Icon(Icons.add_circle_outline,
                            color: Colors.white60),
                      ),
                    ],
                  ),
                ),
                Container(
                  // color: Colors.green,
                  width: rightSideWidth * 0.8,
                  alignment: Alignment.center,
                  child: Text(
                    "\$" + itemList.listOfItems[index].item.price.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.normal,
                      fontSize: rightSideWidth * 0.2,
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

  Widget subtitle(double sectionHeight, double screenWidth) {
    final itemList = Provider.of<ListOfCartItems>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          // color: Colors.red,
          height: sectionHeight,
          width: screenWidth * 0.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.02),
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: sectionHeight * 0.5,
                ),
              ),
              Text(
                "Order summary",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Manrope',
                  fontSize: sectionHeight * 0.3,
                ),
              ),
            ],
          ),
        ),
        Container(
          // color: Colors.green,
          width: screenWidth * 0.5,
          height: sectionHeight,
          alignment: Alignment.centerRight,
          child: TextButton(
            style: ButtonStyle(
              overlayColor: itemList.listOfItems.isEmpty
                  ? MaterialStateColor.resolveWith(
                      (states) => Colors.transparent)
                  : MaterialStateColor.resolveWith(
                      (states) => Colors.grey[800]!,
                    ),
            ),
            onPressed: () {
              setState(() {
                itemList.clearQueue();
              });
            },
            child: Text(
              "Remove all",
              style: TextStyle(
                color: itemList.listOfItems.isEmpty
                    ? Colors.grey[700]
                    : Colors.white,
                fontWeight: FontWeight.normal,
                fontFamily: 'Manrope',
                fontSize: sectionHeight * 0.4,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    );
  }

  Widget paymentButton(double sectionHeight, double screenWidth) {
    final itemList = Provider.of<ListOfCartItems>(context);
    return Container(
      height: sectionHeight * 0.7,
      child: TextButton(
        style: ButtonStyle(
          overlayColor: itemList.listOfItems.isEmpty
              ? MaterialStateColor.resolveWith((states) => Colors.transparent)
              : MaterialStateColor.resolveWith(
                  (states) => Colors.lightGreenAccent[400]!),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          backgroundColor: itemList.listOfItems.isEmpty
              ? MaterialStateColor.resolveWith((states) => Colors.grey[800]!)
              : MaterialStateColor.resolveWith(
                  (states) => Colors.lightGreenAccent[400]!),
        ),
        onPressed: () =>
            {if (itemList.listOfItems.isNotEmpty) checkoutDialog(context)},
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sectionHeight * 0.2),
          child: Text(
            'Payment Info',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w800,
              fontFamily: 'Manrope',
            ),
          ),
        ),
      ),
    );
  }
}

class TotalPrice extends StatefulWidget {
  final double sectionHeight, screenWidth;
  TotalPrice({
    Key? key,
    required this.sectionHeight,
    required this.screenWidth,
  }) : super(key: key);

  @override
  _TotalPriceState createState() => _TotalPriceState();
}

class _TotalPriceState extends State<TotalPrice> {
  @override
  Widget build(BuildContext context) {
    TextStyle normalStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontFamily: 'Manrope',
      fontSize: widget.sectionHeight * 0.1,
    );
    TextStyle boldStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w800,
      fontFamily: 'Manrope',
      fontSize: widget.sectionHeight * 0.1,
    );
    final itemList = Provider.of<ListOfCartItems>(context);
    return Container(
      // color: Colors.yellow,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: widget.sectionHeight * 0.27,
            ),
            child: Divider(color: Colors.white30),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: widget.sectionHeight * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Subtotal",
                  style: normalStyle,
                ),
                Text(
                  "\$" + itemList.subTotal.toString(),
                  style: normalStyle,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: widget.sectionHeight * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Shipping fees",
                  style: normalStyle,
                ),
                Text(
                  "\$" + itemList.shippingFees.toString(),
                  style: normalStyle,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total (including tax)",
                style: boldStyle,
              ),
              Text(
                "\$" + itemList.total.toString(),
                style: boldStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
