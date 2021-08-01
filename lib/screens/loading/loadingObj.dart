import 'package:flutter/cupertino.dart';

class LoadingVar with ChangeNotifier {
  bool loading = true;
  LoadingVar({loading});

  toggle() {
    loading = !loading;
    notifyListeners();
  }
}
