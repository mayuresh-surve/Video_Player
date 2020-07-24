import 'package:player/mychannel.dart';
import 'package:player/flutter_player_icons.dart';
import 'package:flutter/material.dart';
import 'package:player/trending.dart';
import 'package:player/following.dart';
import 'package:player/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var screenWidth;
  var screenHeight;
  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(title: 'Home'),
    trending(title: 'Trending'),
    following(title: 'Following')
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 18,),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(FlutterPlayer.graph, size: 16,),
              title: Text('Trending'),
            ),
            BottomNavigationBarItem(
              icon: Icon(FlutterPlayer.heart, size: 16,),
              title: Text('Following'),
            )
          ],
        ),
    );
  }
}
