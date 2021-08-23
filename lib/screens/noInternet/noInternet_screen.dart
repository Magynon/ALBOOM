import 'package:app/screens/auth/authenticate.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitThreeBounce(
              color: Colors.green,
              size: 50.0,
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: screenWidth < screenHeight
                      ? screenWidth * 0.1
                      : screenHeight * 0.1),
              child: Text(
                'Seems that your Internet connection\nis very slow or inexistent...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: screenWidth < screenHeight
                      ? screenWidth * 0.03
                      : screenHeight * 0.03,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Reconnect!",
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
