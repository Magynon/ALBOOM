import 'package:app/actions/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();
  bool loginBool = true;
  String error = '';

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
    ]);
    username.dispose();
    password.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: screenHeight,
                width: screenWidth,
                color: Theme.of(context).primaryColor,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset(
                    "assets/images/loginBg/bg.jpg",
                  ),
                ),
              ),
              Container(
                height: screenHeight,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Container(
                  // color: Colors.blue,
                  child: Column(
                    children: [
                      title(screenWidth * 0.8, screenHeight * 0.2),
                      login(screenWidth * 0.8, screenHeight * 0.5),
                      suggestion(screenWidth, screenHeight),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget title(double sectionWidth, double sectionHeight) {
    return Container(
      // color: Colors.orange,
      height: sectionHeight,
      width: double.infinity,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          "ALBOOM".toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Manrope",
            fontSize: sectionHeight * 0.25,
          ),
        ),
      ),
    );
  }

  Widget suggestion(double screenWidth, double screenHeight) {
    return loginBool
        ? signUpSuggestion(screenWidth * 0.8, screenHeight * 0.2)
        : signInSuggestion(screenWidth * 0.8, screenHeight * 0.2);
  }

  Widget login(double sectionWidth, double sectionHeight) {
    return Container(
      height: sectionHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(sectionHeight * 0.06),
              child: Icon(
                Icons.person,
                color: Colors.grey,
                size: sectionHeight * 0.08,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sectionWidth * 0.15),
              child: TextFormField(
                controller: username,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  color: Colors.grey[800],
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.only(
                    left: 20,
                    top: sectionHeight * 0.04,
                    bottom: sectionHeight * 0.04,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: 'Username',
                  hintStyle: TextStyle(
                    color: Colors.grey[800],
                    fontSize: sectionHeight * 0.03,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sectionWidth * 0.15,
                  vertical: sectionHeight * 0.06),
              child: TextFormField(
                controller: password,
                obscureText: true,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  color: Colors.grey[800],
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.only(
                    left: 20,
                    top: sectionHeight * 0.04,
                    bottom: sectionHeight * 0.04,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Colors.grey[800],
                    fontSize: sectionHeight * 0.03,
                  ),
                ),
              ),
            ),
            buttonSelector(sectionWidth, sectionHeight),
            SizedBox(
              height: sectionHeight * 0.03,
            ),
            Text(
              error,
              style: TextStyle(
                color: Colors.red,
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: sectionHeight * 0.07,
            ),
            GestureDetector(
              onTap: () async {
                await _auth.signInAnon();
              },
              child: Text(
                "Forgot password? Anonymous login!",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonSelector(double sectionWidth, double sectionHeight) {
    return loginBool
        ? signInButton(sectionWidth * 0.5, sectionHeight * 0.13)
        : registerButton(sectionWidth * 0.5, sectionHeight * 0.13);
  }

  Widget signInButton(double sectionWidth, double sectionHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: sectionHeight * 0.1),
      child: Container(
        height: sectionHeight,
        width: sectionWidth,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            splashFactory: NoSplash.splashFactory,
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              dynamic result = await _auth.signInWithEmailAndPassword(
                  username.text, password.text);
              if (result == null) {
                setState(() {
                  error = 'Invalid credentials!';
                });
              }
            }
          },
          child: Ink(
            padding: EdgeInsets.zero,
            width: sectionWidth,
            height: sectionHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.lightGreenAccent, Colors.black],
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Center(
              child: Text(
                'SIGN IN'.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Manrope',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget registerButton(double sectionWidth, double sectionHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: sectionHeight * 0.1),
      child: Container(
        height: sectionHeight,
        width: sectionWidth,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            splashFactory: NoSplash.splashFactory,
          ),
          onPressed: () async {
            // print("Username: " + username.text);
            // print("Password: " + password.text);
            if (_formKey.currentState!.validate()) {
              dynamic result = await _auth.registerWithEmailAndPassword(
                  username.text, password.text);
              if (result == null) {
                setState(() {
                  error = "Please provide valid credentials";
                });
              }
            }
          },
          child: Ink(
            padding: EdgeInsets.zero,
            width: sectionWidth,
            height: sectionHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.lightGreenAccent, Colors.black],
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Center(
              child: Text(
                'REGISTER'.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Manrope',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget signUpSuggestion(double sectionWidth, double sectionHeight) {
    return Container(
      width: sectionWidth,
      height: sectionHeight,
      // color: Colors.orange,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account?",
            style: TextStyle(color: Colors.grey[700]),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                loginBool = !loginBool;
              });
            },
            child: Text(
              "Register",
              style: TextStyle(color: Colors.lightGreen),
            ),
          ),
        ],
      ),
    );
  }

  Widget signInSuggestion(double sectionWidth, double sectionHeight) {
    return Container(
      width: sectionWidth,
      height: sectionHeight,
      // color: Colors.orange,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account?",
            style: TextStyle(color: Colors.grey[700]),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                loginBool = !loginBool;
              });
            },
            child: Text(
              "Sign In",
              style: TextStyle(color: Colors.lightGreen),
            ),
          ),
        ],
      ),
    );
  }
}
