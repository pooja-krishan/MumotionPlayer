import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mumotionplayer/constants.dart';
import 'package:mumotionplayer/models/playlist_model.dart';
import 'package:mumotionplayer/screens/screens/custom_widget.dart';
import 'package:mumotionplayer/screens/screens/songList_screen.dart';

// ignore: must_be_immutable
class PlayListScreen extends StatelessWidget {
  final List<Playlist> playlists;
  final String title;
  final bool live;

  const PlayListScreen({Key key, this.playlists, this.title, this.live})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        leading: Text(''),
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: live
            ? Row(
                children: [
                  SizedBox(
                    width: 70,
                  ),
                  SpinKitRipple(
                    color: Colors.red,
                    size: 25.0,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style: TextStyle(color: AppColors.styleColor),
                  ),
                ],
              )
            : Text(
                title,
                style: TextStyle(color: AppColors.styleColor),
              ),
      ),
      body: Container(
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (_, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomWidget(
              image: "${playlists[index].image}",
              size: 120,
              radius: false,
              borderWidth: 5,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SongListScreen(
                            playlists: playlists[index],
                            songOnly: false,
                        assetOnly: true,
                        listData: null,
                          ))),
            ),
          ),
          itemCount: playlists.length,
        ),
      ),
    );
  }
}
