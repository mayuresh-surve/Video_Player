import 'package:player/mychannel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:player/videoplayer.dart';

class following extends StatefulWidget {
  following({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _followingState createState() => _followingState();
}

class _followingState extends State<following> {
  var screenHeight;
  var screenWidth;

  Widget _buildNewPost(BuildContext context, int value) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    height: screenHeight * 0.25,
                    width: screenWidth * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        image: AssetImage('assets/firework.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Videoplayer()));
                  },
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            Container(
              width: screenWidth * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      child: Text(
                          'Video Name, Lengthning the Title for the Idea of the Title Placement',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18.0))),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Videoplayer()));
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Container(
              width: screenWidth * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Channel Name',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(fontSize: 14.0)),
                  ),
                  SizedBox(
                    width: screenWidth * 0.1,
                  ),
                  Text(
                    '2.7k Views',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(fontSize: 14.0)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Mychannel(
                                    title: 'Channel Name',
                                  )));
                    },
                    child: Image.asset(
                      'assets/Profile-1.png',
                      height: screenHeight * 0.05,
                      width: screenHeight * 0.05,
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.title,
                    style: TextStyle(
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w400,
                        fontSize: 18.0),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/Path 99.png',
                    height: screenHeight * 0.025,
                    width: screenHeight * 0.025,
                  ),
                ],
              )
            ],
          ),
          backgroundColor: Colors.white,
        ),
        body: ListView.separated(
            itemBuilder: (context, index) => _buildNewPost(context, 4),
            separatorBuilder: (context, index) => Divider(
                  color: Colors.grey.shade200,
                ),
            itemCount: 4));
  }
}
