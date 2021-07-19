import 'package:flutter/foundation.dart';

class ChangeAuth with ChangeNotifier {
  bool showLogin = true;
  changeState() {
    showLogin = !showLogin;
    print(showLogin);
    notifyListeners();
  }
}
