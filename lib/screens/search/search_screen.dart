import 'package:app/screens/search/searchList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchedItem = TextEditingController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    searchedItem.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
    ]);
    searchedItem.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    print('Text field: ${searchedItem.text}');
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.9;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          child: ListView(
            shrinkWrap: true,
            children: [
              Wrap(
                children: [
                  Center(
                    child: Container(
                      // color: Colors.orange,
                      height: screenHeight * 0.1,
                      width: screenWidth,
                      child: inputField(
                          screenHeight * 0.1, screenWidth, searchedItem),
                    ),
                  ),
                ],
              ),
              AlbumSearchList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputField(double sectionHeight, double screenWidth,
      TextEditingController searchedItem) {
    return Padding(
      padding: EdgeInsets.only(
        top: sectionHeight * 0.3,
      ),
      child: TextField(
        controller: searchedItem,
        textAlignVertical: TextAlignVertical.top,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(
            left: 20,
            top: sectionHeight * 0.2,
            bottom: sectionHeight * 0.2,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(30),
          ),
          hintText: 'Type in album...',
          hintStyle: TextStyle(
            color: Colors.grey[800],
            fontSize: sectionHeight * 0.25,
          ),
        ),
      ),
    );
  }
}
