import 'package:app/screens/creditsScreen.dart';
import 'package:flutter/material.dart';

executeCommand(BuildContext context, String command) {
  switch (command) {
    case 'themeChange':
      themeChange(context);
      break;
    case 'creditsDialog':
      creditsDialog(context);
      break;
  }
}

themeChange(BuildContext context) {}

creditsDialog(BuildContext context) {
  WidgetsBinding.instance!.addPostFrameCallback((_) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Credits()),
      ));
}
