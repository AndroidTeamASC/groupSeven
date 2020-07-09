import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Favourite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SaveNews(),
    );
  }
}

class SaveNews extends StatefulWidget {
  @override
  _SaveNewsState createState() => _SaveNewsState();
}

class _SaveNewsState extends State<SaveNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Save News',style: GoogleFonts.libreBaskerville(fontSize: 27,color: Colors.grey[700])),
      ),
    );
  }
}