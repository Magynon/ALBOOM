import 'package:app/screens/auth/authBool.dart';
import 'package:app/screens/auth/login_screen.dart';
import 'package:app/screens/current_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    final showLogin = Provider.of<ChangeAuth>(context);
    return showLogin.showLogin ? LoginScreen() : CurrentScreen();
  }
}