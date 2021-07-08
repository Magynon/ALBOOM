import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> settingOptions = [
    "Change app theme",
    "Credits",
    "App version",
  ];
  List<IconData?> iconOptions = [
    Icons.thermostat,
    Icons.book,
    Icons.copyright,
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
            physics: NeverScrollableScrollPhysics(),
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
    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.1,
        right: screenWidth * 0.1,
        top: screenHeight * 0.02,
        bottom: screenHeight * 0.02,
      ),
      child: Container(
        decoration: BoxDecoration(
            // border: Border.all(
            //   color: Colors.white12,
            //   width: 1,
            // ),
            // borderRadius: BorderRadius.circular(20),
            ),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onTap: () => {},
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
                  color: Colors.greenAccent[100],
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
