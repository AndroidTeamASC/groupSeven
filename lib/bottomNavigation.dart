import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:group_seven/favourite.dart';

import 'myHome.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  Widget _showPage = MyHome();
  Widget _pageChooses(int page){
    switch (page){
      case 0:
      return MyHome();
      break;
      case 1:
      return Favourite();
      break;
    }
  }
  final MyHome _myHome = MyHome();
  final Favourite _favourite = Favourite();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        height: 40,
        items: <Widget>[
          Icon(Icons.home, size: 30,color: Colors.red),
      Icon(Icons.favorite, size: 30,color: Colors.red,),
        ],
        color: Colors.white,
        backgroundColor: Colors.blueAccent,
        buttonBackgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
      setState(() {
        _showPage = _pageChooses(index);
    
      });
    },),
      body: Center(
        child: _showPage
      ),
    );
  }
}