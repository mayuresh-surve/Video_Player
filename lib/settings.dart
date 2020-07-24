import 'package:player/flutter_player_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatefulWidget {
  Settings({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var screenWidth;
  var screenHeight;

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
            Text('')
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:20.0, left: 15.0),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                FlutterPlayer.clipboard,
                size: 30,
              ),
              title: Padding(
                padding: const EdgeInsets.only(left:15.0),
                child: Text('General',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 18.0))),
              ),
            ),
            ListTile(
              leading: Icon(
                FlutterPlayer.lock,
                size: 32,
              ),
              title: Padding(
                padding: const EdgeInsets.only(left:15.0),
                child: Text('Privacy ans Security',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 18.0))),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
                size: 32,
              ),
              title: Padding(
                padding: const EdgeInsets.only(left:15.0),
                child: Text('Account',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 18.0))),
              ),
            ),
            ListTile(
              leading: Icon(
                FlutterPlayer.moon,
                size: 30,
              ),
              title: Padding(
                padding: const EdgeInsets.only(left:15.0),
                child: Text('Change to Dark Theme',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 18.0))),
              ),
            ),
            ListTile(
              leading: Icon(
                FlutterPlayer.tag,
                size: 30,
              ),
              title: Padding(
                padding: const EdgeInsets.only(left:15.0),
                child: Text('Billing and Payments',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 18.0))),
              ),
            ),
            ListTile(
              leading: Icon(
                FlutterPlayer.info_circled,
                size: 30,
              ),
              title: Padding(
                padding: const EdgeInsets.only(left:15.0),
                child: Text('About',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 18.0))),
              ),
            ),
            ListTile(
              leading: Icon(
                FlutterPlayer.logout,
                size: 30,
              ),
              title: Padding(
                padding: const EdgeInsets.only(left:15.0),
                child: Text('Logout',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 18.0))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
