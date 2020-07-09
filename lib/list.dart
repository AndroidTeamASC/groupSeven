import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class News{
  final String description;
  final String urlToImage;
  final String title;
  final String author;
  final String publishedAt;

  News(this.description,this.urlToImage,this.title,this.author,this.publishedAt);
}
class Every extends StatefulWidget {
   @override
   _EveryState createState() => _EveryState();
 }

 class _EveryState extends State<Every> {
   Future<List<News>> getNews() async{
     var data = await http.get(
       'http://newsapi.org/v2/everything?domains=wsj.com&apiKey=2eca35277ef14b869d67d502240ffaf3');
       var jsonData = json.decode(data.body);
       var newsData = jsonData['articles'];
       print(newsData);
        List<News> news = [];

        for(var data in newsData){
      News newsItem = News(
        data['description'],
        data['urlToImage'],
        data['title'],
        data['author'],
        data['publishedAt']
      );
      news.add(newsItem);
    }
    return news;
  }
   
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.transparent,
       appBar: AppBar(
       leading: InkWell(
         onTap: () => Navigator.pop(context),
         child: Icon(Icons.arrow_back_ios),
       ),
       elevation: 0,
       ),
     body: Container(
       child: FutureBuilder(
         future: getNews(),
         builder: (BuildContext context,AsyncSnapshot snapshot){
           if(snapshot.data==null){
             return Container(
               child:Center(
                 child:CircularProgressIndicator(),
               ),
             );
           }else{
             return ListView.builder(
               itemCount: snapshot.data.length,
               itemBuilder: (BuildContext context, int index){
                 return InkWell(
                   onTap: (){ },

                   child: Card(
                     child: Row(
                       children:[
                         Container(
                           width: 120.0,
                           height: 120.0,
                           child: ClipRRect(
                             borderRadius: BorderRadius.only(
                               topLeft: const Radius.circular(8.0),
                               bottomLeft: const Radius.circular(8.0)
                             ),
                             child: (snapshot.data[index].urlToImage == null)?Image.network('https://www.cleverfiles.com/howto/wp-content/uploads/2018/03/minion-1200x675.jpg')
                             :Image.network(
                               snapshot.data[index].urlToImage,
                               width: 100,
                               fit: BoxFit.fill,
                             ),
                           ),
                         ),
                         Expanded(
                           child: ListTile(
                             title: Text(snapshot.data[index].title),
                             subtitle: Text(snapshot.data[index].author == null
                             ? 'Unknow': snapshot.data[index].author),
                           ),
                         )
                       ],

                     ),
                   ),
                 );
               },
             );
           }
         },
       ),
     )
     );
   }
 }