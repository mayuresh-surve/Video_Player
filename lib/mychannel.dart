import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:player/followerslist.dart';
import 'package:player/followinglist.dart';
import 'package:player/settings.dart';

import 'flutter_player_icons.dart';

class Mychannel extends StatefulWidget {
  Mychannel({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MychannelState createState() => _MychannelState();
}

class _MychannelState extends State<Mychannel>
    with SingleTickerProviderStateMixin {
  var screenWidth;
  var screenHeight;

  TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  Widget _buildUploads(BuildContext context, int value) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: screenHeight * 0.12,
                  width: screenWidth * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage('assets/firework.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: screenWidth * 0.02,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: screenWidth * 0.5,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                            'Video Name, Lengthning the Title for the Idea of the Title Placement',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 11.0))),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('04:08 min',
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.grey.shade700, fontSize: 10.0)))
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Channel Name',
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w900,
                                fontSize: 10.0))),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    Text('2.7k Views',
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.grey.shade700, fontSize: 10.0)))
                  ],
                )
              ],
            )
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
            GestureDetector(
              onTap: () => {Navigator.pop(context)},
              child: Image.asset(
                'assets/Back.png',
                height: screenHeight * 0.025,
                width: screenHeight * 0.025,
              ),
            ),
            Text(
              widget.title,
              style: TextStyle(
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0),
            ),
            GestureDetector(
              child: Icon(
                FlutterPlayer.settings,
                color: Colors.grey.shade700,
                size: 28,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Settings(
                      title: 'Settings',
                    ),
                  ),
                );
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: screenHeight * 0.07,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/Profile-1.png',
                      height: screenHeight * 0.08,
                      width: screenHeight * 0.08,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    children: <Widget>[
                      Text('Channel Name',
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20.0)))
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/Upload.png',
                      width: screenWidth * 0.4,
                      height: screenHeight * 0.055,
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        '140',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.grey.shade700,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('Videos',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ))
                    ],
                  )
                ],
              ),
              GestureDetector(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('24k',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.grey.shade700,
                            ))
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('Followers',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                            ))
                      ],
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Followerslist(
                                title: 'Followers',
                              )));
                },
              ),
              GestureDetector(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('24k',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.grey.shade700,
                            ))
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Following',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Followinglist(
                                title: 'Following',
                              )));
                },
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.05,
          ),
          TabBar(
            controller: _controller,
            labelColor: Colors.grey,
            tabs: <Widget>[
              Tab(
                text: 'New Uploads',
              ),
              Tab(
                text: 'All Videos',
              )
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _controller,
              physics: ScrollPhysics(),
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) =>
                            _buildUploads(context, 3),
                        itemCount: 5,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) =>
                            _buildUploads(context, 3),
                        itemCount: 5,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
