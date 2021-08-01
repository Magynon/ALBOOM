import 'package:app/screens/current_screen.dart';
import 'package:app/screens/loading/loadingObj.dart';
import 'package:app/screens/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    var loading = Provider.of<LoadingVar>(context);
    return loading.loading ? Loading() : CurrentScreen();
  }
}
