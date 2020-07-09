import 'dart:convert';
//import 'package:google_fonts/google_fonts.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'list.dart';
class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home:  TopHeadlines()
    );
  }
}
class Top{
   final String name;
   final String urlToImage;

   Top(this.name,this.urlToImage);
 }

class News{
  final String urlToImage;
  final String title;
  final String description;
  final String author;
  final String publishedAt;
  

  News(this.urlToImage,this.title,this.description,this.author,this.publishedAt,);
}




 class TopHeadlines extends StatelessWidget{
   Future<List<Top>> getTop() async{
//var every = await http.get('http://newsapi.org/v2/everything?q=bitcoin&from=2020-06-07&sortBy=publishedAt&apiKey=2eca35277ef14b869d67d502240ffaf3');
   //  var jsonData = json.decode(every.body);
     var data = await http.get(
       'http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=2eca35277ef14b869d67d502240ffaf3');
     var jsonData = json.decode(data.body);

      var topData = jsonData['articles'];

       List<Top> top = [];
              for(var data in topData){
         Top topItem = Top(
           data['name'],
           data['urlToImage'],
         );
         top.add(topItem);
      }
      return top;
   }
   @override
  Widget build(BuildContext context) {
     return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('News',style: GoogleFonts.libreBaskerville(fontSize: 27,color: Colors.grey[700])),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite,color: Colors.pink[200],size: 30.0,),
               onPressed: ()async{
                 await Navigator.push(
                   context,
                 MaterialPageRoute(builder: (context) => Every()),
                 );

              }
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
             child: FutureBuilder(
            future: getTop(),
            builder:(BuildContext context,AsyncSnapshot snapshot){
              if(snapshot.data == null){
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }else{
               return Container(
                  margin: EdgeInsets.all(12),
                  height: 170.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    return InkWell(
                      onTap: (){},
                      child: Card(
                        child: Wrap(
                          children: <Widget>[
                            Container(
                              width: 330.0,
                              //height: 190.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                child: (snapshot.data[index].urlToImage == null)?Image.network('https://www.cleverfiles.com/howto/wp-content/uploads/2018/03/minion-1200x675.jpg')
                                : Image.network(
                                  snapshot.data[index].urlToImage,
                                
                                )
                              ),
                            )
                          ],
                        ),
                      ),
                      );
                  }
                  )
                );
              }

            }
          ),
            ),Container(
              height: 70.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child:
                  Text('Popular',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 22.0),),),
                  Container(
                    margin: EdgeInsets.only(right: 18.0),
                    child:ClipRRect( 
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                    child: RaisedButton(
                      child: 
                    Text('see all',style: TextStyle(color: Colors.white,fontSize: 14.0),),
                    color: Colors.pink,
                    onPressed: () async{
                      await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Every()));
                    },
                  )
                  )
                  )
                ],
              ),
            
            ),

            Expanded(child: EveryThing())
          ]
            
        )
      );
   }
 }

 class EveryThing extends StatefulWidget {
   @override
   _EveryThingState createState() => _EveryThingState();
 }
 
 class _EveryThingState extends State<EveryThing> {
   Future<List<News>> getNews() async{
     var data = await http.get(
       'http://newsapi.org/v2/everything?domains=wsj.com&apiKey=2eca35277ef14b869d67d502240ffaf3');
       var jsonData = json.decode(data.body);
       var newsData = jsonData['articles'];
       print(newsData);
        List<News> news = [];

        for(var data in newsData){
      News newsItem = News(
        data['urlToImage'],
        data['title'],
        data['description'],
        data['author'],
        data['publishedAt']
      );
      news.add(newsItem);
    }
    return news;
  }
   
   @override
   Widget build(BuildContext context) {
     return Container(
       margin: EdgeInsets.only(left: 12.0,right: 12.0),
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
                   onTap: (){
                     News news = new News (
                       snapshot.data[index].urlToImage,
                       snapshot.data[index].title,
                       snapshot.data[index].description,
                       snapshot.data[index].author,
                       snapshot.data[index].publishedAt);

                       Navigator.push(
                        context,
                      MaterialPageRoute(builder: (context) => new DetailScreen(news: news)));
                   },

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
     );
   }
 }

 class DetailScreen extends StatelessWidget{

static const routeName = '/detailScreen';
final News news;

DetailScreen({this.news});

//List<News> detil = [];
  @override
  Widget build(BuildContext context) {
      
    return Scaffold(
        appBar: AppBar(
          title: Text('Detail Screen'),
        ),
        body: Center(
          child: Container(
                child: Column(
                  children: [
                      Stack(
                        children: [
                          Container(
                            height: 200.0,
                            child:(this.news.urlToImage == null)? Image.network('https://www.cleverfiles.com/howto/wp-content/uploads/2018/03/minion-1200x675.jpg')
                            :Image.network(this.news.urlToImage,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            SizedBox(height: 10.0,),
                            Text(this.news.title,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.2,
                              wordSpacing: 0.6,
                            ),),
                            SizedBox(height: 20.0,),
                            Text(
                              this.news.description == null
                              ?'No Description'
                              :this.news.description,
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 16.0,
                                letterSpacing: 0.2,
                                wordSpacing: 0.3,
                              ),
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(child: 
                                Text(
                                  this.news.author == null
                                  ?'Unknow'
                                  : this.news.author,
                                  style: GoogleFonts.dancingScript(color: Colors.grey[700],fontSize: 18.0,fontWeight: FontWeight.bold),
                                ),
                                ),
                                Expanded(child: 
                                Text(
                                  this.news.publishedAt == null
                                  ?'Nothing'
                                  : this.news.publishedAt,
                                  style: TextStyle(color: Colors.grey),
                                ),
                                )
                              ],
                            )
                          ],
                        ), ),    
                    
                  ],
                ),

              
            )
        
        ),
    );
    
  }

}
