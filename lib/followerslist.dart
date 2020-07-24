import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Followerslist extends StatefulWidget {
  Followerslist({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FollowerslistState createState() => _FollowerslistState();
}

class _FollowerslistState extends State<Followerslist> {
  var screenWidth;
  var screenHeight;

  Widget _buildFollowerList(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, bottom: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                GestureDetector(
                  child: Image.asset(
                    'assets/Profile-1.png',
                    height: screenHeight * 0.08,
                    width: screenHeight * 0.08,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    child: Text('Channel Name',
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w900,
                                fontSize: 14.0))),
                  ),
                  Text('123k Followers',
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.grey.shade700, fontSize: 10.0)))
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Image.asset(
                  'assets/Follow.png',
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.055,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () => {Navigator.pop(context)},
                  child: Image.asset(
                    'assets/Back.png',
                    height: screenHeight * 0.025,
                    width: screenHeight * 0.025,
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
                  'assets/Menu.png',
                  height: screenHeight * 0.025,
                  width: screenHeight * 0.025,
                ),
              ],
            )
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/Profile-1.png',
                  height: screenHeight * 0.08,
                  width: screenHeight * 0.08,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Channel Name',
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20.0))),
                      Text('123k followers | 123k following',
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.grey.shade700, fontSize: 12.0)))
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.only(left:25.0, bottom: 20.0, top: 20.0),
            child: Row(
              children: <Widget>[
                Text('Followers',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w900,
                            fontSize: 16.0))),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, int) => _buildFollowerList(context),
              itemCount: 10,
              shrinkWrap: true,
              physics: ScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }
}
