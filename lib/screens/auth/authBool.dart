import 'package:flutter/foundation.dart';

class ChangeAuth with ChangeNotifier {
  late bool showLogin;

  ChangeAuth() {
    showLogin = true;
  }

  changeState() {
    showLogin = !showLogin;
    notifyListeners();
  }
}
