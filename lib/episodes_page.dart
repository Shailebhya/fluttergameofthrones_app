import 'package:flutter/material.dart';

import 'got.dart';
class EpisodesPage extends StatelessWidget {
  final List<Episodes> episodes;
  final MyImage myImage;
BuildContext _context;
  EpisodesPage({this.myImage,this.episodes});

  showSummary(String summary){
    showDialog(context: _context,builder: (context) => Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
child: Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Text(summary),
),
        ),
      ),
    ));
  }
  Widget myBody(){
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemCount: episodes.length,
        itemBuilder: (context,index) => InkWell(
          onTap: (){
            showSummary(episodes[index].summary);
          },
          child: Card(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(episodes[index].image.original,
                fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(episodes[index].name,style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    color: Colors.red,
                    child: Text("${episodes[index].season}- ${episodes[index].number}",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold

                    ),)
                    ,
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Row(
          children: [
            Hero(
              tag: "g1",
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  myImage.medium
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text("All Episodes")
          ],
        )
      ),
      body:myBody() ,
    );
  }
}
