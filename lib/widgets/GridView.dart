import 'package:flutter/material.dart';
import 'package:mumotionplayer/widgets/genrasWidget.dart';

class GridViewList extends StatefulWidget {
  @override
  _GridViewListState createState() => _GridViewListState();
}

class _GridViewListState extends State<GridViewList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
     children: [
       SingleChildScrollView(
         scrollDirection: Axis.vertical,
         child: Column(
           children: [
             Padding(
               padding: const EdgeInsets.fromLTRB(5, 15, 0, 20),
               child: Text("Mood",
                   style: TextStyle(
                       color: Colors.grey[200],
                       fontSize: 20,
                       fontWeight: FontWeight.bold)),
             ),
             GenreGridView(
               genre: "",
               name1: "Happy",
               name2: "Sad",
               name3: "Fear",
               name4: "Surprise",
               color1: Colors.red,
               color2: Colors.greenAccent,
               color3: Colors.blueGrey,
               color4: Colors.pinkAccent,
               url1:
               "https://images.pexels.com/photos/4571219/pexels-photo-4571219.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
               url2:
               "https://images.pexels.com/photos/2479312/pexels-photo-2479312.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
               url3:
               "https://images.pexels.com/photos/3618362/pexels-photo-3618362.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
               url4:
               "https://images.pexels.com/photos/761963/pexels-photo-761963.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
             ),
           ],
         ),
       ),
     ],
    );
  }
}
