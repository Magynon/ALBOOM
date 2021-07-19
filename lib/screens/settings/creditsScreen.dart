import 'package:flutter/material.dart';

class Credits extends StatelessWidget {
  const Credits({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [],
      ),
      body: Container(
        alignment: Alignment.center,
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: screenWidth < screenHeight
                      ? screenWidth * 0.05
                      : screenHeight * 0.05),
              child: Image.asset(
                "assets/images/author/th.png",
                width: screenWidth < screenHeight
                    ? screenWidth * 0.5
                    : screenHeight * 0.5,
              ),
            ),
            Text(
              "Stefan Magirescu",
              style: TextStyle(
                color: Colors.grey[400],
                fontWeight: FontWeight.w300,
                fontSize: screenWidth < screenHeight
                    ? screenWidth * 0.05
                    : screenHeight * 0.05,
              ),
            ),
            Text(
              "Universitatea Politehnica Bucuresti",
              style: TextStyle(
                color: Colors.grey[400],
                fontWeight: FontWeight.w300,
                fontSize: screenWidth < screenHeight
                    ? screenWidth * 0.04
                    : screenHeight * 0.04,
              ),
            )
          ],
        ),
      ),
    );
  }
}
