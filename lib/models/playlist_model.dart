
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mumotionplayer/models/song_model.dart';

class Playlist {
  final String title;
  final String image;
  final bool shuffle;
  final String likes;
  final String song;
  final List<Song> songs;

  Playlist({this.title, this.image, this.shuffle, this.likes, this.songs,this.song});
}

class Moods{
  final String title;
  final String subTitle;
  final Color color;
  final String image;
  final List<Playlist> playlists;

  Moods({this.title, this.color, this.image,this.playlists,this.subTitle});
}


class SongListData{
  final String uri;
  final String imageUri;
  final String playListName;
  SongListData({this.uri, this.imageUri,this.playListName});
}

class CameraModeClass{
  final bool cameraMode;

  CameraModeClass({this.cameraMode});
}
