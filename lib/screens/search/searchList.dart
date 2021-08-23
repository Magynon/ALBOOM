import 'package:app/objects/album.dart';
import 'package:flutter/material.dart';

class AlbumSearchList extends StatelessWidget {
  AlbumSearchList({Key? key}) : super(key: key);

  final album = Album(
    band: 'Rising Force',
    coverArt:
        "https://firebasestorage.googleapis.com/v0/b/alboom-a2b32.appspot.com/o/images%2Falbums%2F1.jpg?alt=media&token=de5e38b7-36ee-4b08-888a-82519a904fa9",
    label: 'Polydor',
    like: false,
    name: "Trilogy",
    price: 10,
    url: "www.google.com",
    year: "1984",
  );

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    int noOfReturnedAlbums = 1;

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                // padding: EdgeInsets.only(top: 10),
                shrinkWrap: true,
                itemCount: noOfReturnedAlbums,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.02),
                    child: _listElement(index, screenHeight * 0.1, screenWidth),
                  );
                }),
          ),
        ),
      ],
    );
  }

  Widget _listElement(int index, double sectionHeight, double screenWidth) {
    double leftSideWidth = screenWidth * 0.8;
    double imageWidth = leftSideWidth * 0.2;
    double albumDetailsWidth = leftSideWidth * 0.8;

    return Container(
      padding: EdgeInsets.only(bottom: sectionHeight * 0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            // color: Colors.blue,
            width: leftSideWidth,
            height: sectionHeight,
            child: Row(
              children: [
                Container(
                  child: Image.network(
                    album.coverArt,
                    width: imageWidth,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  // color: Colors.red,
                  alignment: Alignment.centerLeft,
                  width: albumDetailsWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: albumDetailsWidth * 0.9,
                        // color: Colors.green,
                        child: Text(
                          album.name,
                          // "Album namekjhjvjvbjhgjn",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Manrope",
                            fontWeight: FontWeight.normal,
                            fontSize: sectionHeight * 0.3,
                          ),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        // color: Colors.black,
                        width: albumDetailsWidth * 0.9,
                        child: Text(
                          album.band + " - " + album.year,
                          // "Band year",
                          style: TextStyle(
                            color: Colors.white54,
                            fontFamily: "Manrope",
                            fontWeight: FontWeight.normal,
                            fontSize: sectionHeight * 0.2,
                          ),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
