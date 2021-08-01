import 'package:flutter/material.dart';
import 'package:mumotionplayer/data/playlists.dart';
import 'package:mumotionplayer/screens/screens/songList_screen.dart';

class DrivingTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('driving tab');
    return Container(
      child: SongListScreen(playlists: drivingModePlaylist[0],songOnly: false,listData: null,assetOnly: false,)
    );
  }
}
