
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:group_seven/bottomNavigation.dart';
import 'package:splashscreen/splashscreen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'News',
     home: FirstScreen()
   );
 }
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(seconds: 15,
    backgroundColor: Colors.black,
    image: Image.asset('images/loading.gif'),
    loaderColor: Colors.white,
    photoSize: 150.0,
    navigateAfterSeconds: BottomNavigation(),);
  }
}


