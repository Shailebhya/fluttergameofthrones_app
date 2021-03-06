import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergameofthrones_app/episodes_page.dart';
import 'package:fluttergameofthrones_app/got.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GOT got;
 String url = "http://api.tvmaze.com/singlesearch/shows?q=game-of-thrones&embed=episodes";
  Widget myCard(){
    return SingleChildScrollView(
      child: Card(
child: Padding(
  padding: const EdgeInsets.all(18.0),
  child:   Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Hero(
          tag: "g1",
          child: CircleAvatar(
            radius: 100,
            backgroundImage: NetworkImage(got.image.original),
          ),
        ),
        SizedBox(height: 20,),
        Text(got.name,style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.green
        ),),
        SizedBox(height: 20,),
        Text("Runtime :${got.runtime.toString()} minutes",style:  TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blue
        )),
        SizedBox(height: 20,),
        Text(got.summary,style:  TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.blue
        )),
        SizedBox(height: 20,),
        RaisedButton(
          color: Colors.red,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder:
                (context)=>EpisodesPage(episodes: got.eEmbedded.episodes,myImage:got.image ,)));
          },
          child: Text("All Episodes",style: TextStyle(
            color: Colors.white
          ))
        )

      ],
  ),
),
      ),
    );
  }
  Widget myBody(){
    return got==null?Center(
      child: CircularProgressIndicator(),
    ):myCard();
  }

  @override
  void initState() {
    super.initState();
    fetchEpisodes();
  }
  fetchEpisodes()async{
    var res =await http.get(url);
    var decodedRes = jsonDecode(res.body);
    print(decodedRes);
    got = GOT.fromJson(decodedRes);
    setState(() {

    });
  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Of Thromes"),

      ),
      body: myBody(),

      floatingActionButton: FloatingActionButton(
        onPressed: fetchEpisodes,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
