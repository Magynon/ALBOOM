import 'package:flutter/material.dart';
import 'creditsScreen.dart';

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

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> settingOptions = [
    "Change app theme",
    "Credits",
  ];
  List<IconData?> iconOptions = [
    Icons.thermostat,
    Icons.book,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Divider(color: Colors.white30),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      color: Colors.white38,
                      fontWeight: FontWeight.w200,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          _settingsList(),
        ],
      )),
    );
  }

  Widget _settingsList() {
    return Expanded(
      child: SizedBox(
        child: ListView.builder(
            padding: EdgeInsets.only(top: 10),
            shrinkWrap: true,
            itemCount: settingOptions.length,
            itemBuilder: (BuildContext context, int index) {
              return _listElement(index);
            }),
      ),
    );
  }

  Widget _listElement(int index) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    List<String> listOfFunctions = [
      "themeChange",
      "creditsDialog",
    ];
    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.1,
        right: screenWidth * 0.1,
        top: screenHeight * 0.02,
        bottom: screenHeight * 0.02,
      ),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onTap: () => executeCommand(context, listOfFunctions.elementAt(index)),
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(
              left: screenWidth * 0.01,
              right: screenWidth * 0.01,
              top: screenHeight * 0.02,
              bottom: screenHeight * 0.02,
            ),
            child: Row(
              children: [
                Icon(
                  iconOptions.elementAt(index),
                  color: Colors.pinkAccent[400],
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.03),
                  child: Text(
                    settingOptions.elementAt(index),
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w300,
                      fontSize: screenHeight * 0.03,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
