import 'package:app/Objects/cartItem.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final ListOfCartItems itemList;
  CartScreen({Key? key, required this.itemList}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height - 70 - 80;
    double screenWidth = MediaQuery.of(context).size.width * 0.9;

    for (int i = 0; i < widget.itemList.listOfItems.length; i++) {
      print(widget.itemList.listOfItems[i].item.name);
      print(widget.itemList.listOfItems[i].quantity);
      print("total: " + widget.itemList.total.toString());
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
                height: screenHeight * 0.2,
                // color: Colors.blue,
                child: TotalPrice(
                  sectionHeight: screenHeight * 0.2,
                  screenWidth: screenWidth,
                  itemList: widget.itemList,
                ),
              ),

              // buttons
              Container(
                height: screenHeight * 0.1,
                // color: Colors.pink,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    cancelButton(screenHeight * 0.1, screenWidth),
                    paymentButton(screenHeight * 0.1, screenWidth),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listOfItems(double screenHeight, double screenWidth) {
    return Expanded(
      child: SizedBox(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.itemList.listOfItems.length,
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
                    widget.itemList.listOfItems[index].item.coverArt,
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
                          widget.itemList.listOfItems[index].item.name,
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
                          widget.itemList.listOfItems[index].item.band +
                              " " +
                              widget.itemList.listOfItems[index].item.year,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            widget.itemList.popItemFromList(
                                widget.itemList.listOfItems[index]);
                          });
                        },
                        icon: Icon(Icons.remove_circle_outline,
                            color: Colors.white60),
                      ),
                      Text(
                        widget.itemList.listOfItems[index].quantity.toString(),
                        style: TextStyle(
                          color: Colors.white54,
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.normal,
                          fontSize: rightSideWidth * 0.2,
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            widget.itemList.addItemToList(
                                widget.itemList.listOfItems[index]);
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
                    "\$" +
                        widget.itemList.listOfItems[index].item.price
                            .toString(),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          // color: Colors.red,
          height: sectionHeight,
          width: screenWidth * 0.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: screenWidth * 0.08,
              ),
              Text(
                "Order summary",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Manrope',
                  fontSize: screenWidth * 0.045,
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
            onPressed: () {
              setState(() {
                widget.itemList.clearQueue();
              });
            },
            child: Text(
              "Remove all",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontFamily: 'Manrope',
                fontSize: screenWidth * 0.04,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    );
  }

  Widget paymentButton(double sectionHeight, double screenWidth) {
    return Container(
      height: sectionHeight * 0.7,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          backgroundColor: MaterialStateColor.resolveWith(
              (states) => Colors.lightGreenAccent[400]!),
        ),
        onPressed: () => {},
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sectionHeight * 0.2),
          child: Text(
            'Payment Info',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w800,
              fontFamily: 'Manrope',
              // fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget cancelButton(double sectionHeight, double screenWidth) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(30.0),
      ),
      height: sectionHeight * 0.7,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          backgroundColor: MaterialStateColor.resolveWith(
              (states) => Theme.of(context).primaryColor),
        ),
        onPressed: () => {},
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sectionHeight * 0.2),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.normal,
              fontFamily: 'Manrope',
              // fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class TotalPrice extends StatefulWidget {
  double sectionHeight, screenWidth;
  final ListOfCartItems itemList;
  TotalPrice({
    Key? key,
    required this.sectionHeight,
    required this.screenWidth,
    required this.itemList,
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
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: widget.sectionHeight * 0.3,
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
                "\$" + widget.itemList.subTotal.toString(),
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
                "\$" + widget.itemList.shippingFees.toString(),
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
                "Total (including tax)",
                style: boldStyle,
              ),
              Text(
                "\$" + widget.itemList.total.toString(),
                style: boldStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
