import 'package:flutter/material.dart';
import 'package:mumotionplayer/screens/Library/Albums.dart';
import 'package:mumotionplayer/screens/Library/Artist.dart';
import 'package:mumotionplayer/screens/Library/playlists.dart';


class MusicTabSection extends StatelessWidget {
  TabController subTabController;

  // MusicTabSection(this.subTabController);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: TabBar(
              labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              labelColor: Colors.white,
              indicatorColor: Colors.green,
              isScrollable: true,
              controller: subTabController,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  text: "Playlists",
                ),
                Tab(
                  text: "Artists",
                ),
                Tab(
                  text: "Albums",
                ),
              ]),
        ),
        body: TabBarView(children: [
          PlaylistScreen(),
          ArtistScreen(),
          AlbumScreen(),
        ]),
      ),
    );
  }
}
