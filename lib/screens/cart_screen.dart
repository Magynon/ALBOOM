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
    double screenHeight = MediaQuery.of(context).size.height - 70 - 80;
    double screenWidth = MediaQuery.of(context).size.width * 0.9;

    for (int i = 0; i < widget.itemList.listOfItems.length; i++) {
      print(widget.itemList.listOfItems[i].item.name);
      print(widget.itemList.listOfItems[i].quantity);
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
                color: Colors.white,
                child: Column(
                  children: [
                    listOfItems(),
                  ],
                ),
              ),

              // final price
              Container(
                height: screenHeight * 0.2,
                // color: Colors.blue,
                child: totalPrice(screenHeight * 0.2, screenWidth),
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

  Widget listOfItems() {
    return Expanded(
      child: SizedBox(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.itemList.listOfItems.length,
            itemBuilder: (BuildContext context, int index) {
              return _listElement(index);
            }),
      ),
    );
  }

  Widget _listElement(int index) {
    return Container(
      child: Text("hello",
          style: TextStyle(
            color: Colors.black,
          )),
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
            onPressed: () => widget.itemList.clearQueue(),
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

  Widget totalPrice(double sectionHeight, double screenWidth) {
    int subtotal = 0;
    int shippingFees = 0;
    int total = 0;

    TextStyle normalStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontFamily: 'Manrope',
      fontSize: sectionHeight * 0.1,
    );
    TextStyle boldStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w800,
      fontFamily: 'Manrope',
      fontSize: sectionHeight * 0.1,
    );

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: sectionHeight * 0.3,
          ),
          child: Divider(color: Colors.white30),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: sectionHeight * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal",
                style: normalStyle,
              ),
              Text(
                "\$" + subtotal.toString(),
                style: normalStyle,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: sectionHeight * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shipping fees",
                style: normalStyle,
              ),
              Text(
                "\$" + shippingFees.toString(),
                style: normalStyle,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: sectionHeight * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total (including tax)",
                style: boldStyle,
              ),
              Text(
                "\$" + total.toString(),
                style: boldStyle,
              ),
            ],
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
