import 'package:flutter/material.dart';
import 'package:mumotionplayer/constants.dart';
import 'package:mumotionplayer/helpers/SharedAxisPageRoute.dart';
import 'package:mumotionplayer/models/playlist_model.dart';
import 'package:mumotionplayer/widgets/PlaylistItem_song.dart';

class PlaylistItem extends StatelessWidget {
  final List<Playlist> playlists;

  const PlaylistItem({Key key, this.playlists}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff4f4f4f),
          Color(0xff121212),
        ], begin: Alignment.topLeft, end: FractionalOffset(0.1, 0.3))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(60, 80, 0, 0),
                child: Text(
                  "PlayLists",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: playlists.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                        left: index == 0 ? 20 : 10,
                        right: index == playlists.length - 1 ? 20 : 10,
                        top: 30),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PlaylistItemSong(data: playlists[index])));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            playlists[index].image,
                            height: 120,
                            width: 120,
                          ),
                          SizedBox(height: 10),
                          Text(playlists[index].title,
                              style: TextStyle(
                                color: Color(0xFFFAFAFA),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              )),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
