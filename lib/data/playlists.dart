import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mumotionplayer/models/artist_model.dart';
import 'package:mumotionplayer/models/playlist_model.dart';
import 'package:mumotionplayer/models/song_model.dart';

final moodPlayList = [
  Playlist(
    title: 'Happy-O-Happy',
    image: 'assets/playlistImage/happy_happy.png',
    shuffle: false,
    likes: '3.5M',
    song: '37i9dQZF1DX2x1COalpsUi',
  ),
  Playlist(
    title: 'Feelin Good',
    image: 'assets/playlistImage/feelin_good.png',
    shuffle: true,
    likes: '2.5M',
    song: '37i9dQZF1DX9XIFQuFvzM4',
  ),
  Playlist(
    title: 'Millenium Melodies',
    image: 'assets/playlistImage/millenium_melodies.png',
    shuffle: false,
    likes: '2.5M',
    song: '37i9dQZF1DX5yXx6e61fbM',
  ),
];

final happyPlayList =[
  Playlist(
      title: 'Happy Mood',
      song: '1fEANyywTj2Bc6hToYLgRZ',
    image:
    'https://images.pexels.com/photos/4571219/pexels-photo-4571219.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',

  )
];
final sadPlayList =[
  Playlist(
      title: 'Sad Mood',
      song: '0CNW1mPyEYi77y1moZJHcv',
    image:
    'https://images.pexels.com/photos/2479312/pexels-photo-2479312.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',

  )
];
final neutralPlayList =[
  Playlist(
      title: 'Neutral Mood',
      song: '3PIwEvGEVPcGc4uDMAEp99',
    image:
    'https://images.pexels.com/photos/3618362/pexels-photo-3618362.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',

  )
];
final surprisePlayList =[
  Playlist(
      title: 'Surprise Mood',
      song: '4ct9TlKw8PkEaSfngZfqeI',
    image:
    'https://images.pexels.com/photos/6966/abstract-music-rock-bw.jpg?auto=compress&cs=tinysrgb&dpr=1&w=500',

  )
];
final angryPlayList =[
  Playlist(
      title: 'Angry Mood',
      song: '0aa8fSqp5latp6zqMaMAWH',
    image:
    'https://images.pexels.com/photos/1389429/pexels-photo-1389429.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',

  )
];
final fearPlayList =[
  Playlist(
      title: 'Fear Mood',
      song: '341LKfbpb6wjO04djs1O0g',
    image:
    'https://images.pexels.com/photos/1876279/pexels-photo-1876279.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',

  )
];
final disgustPlayList =[
  Playlist(
      title: 'Disgust Mood',
      song: '3zGwoVxpoj5cU3emTajM2a',
    image:
    'https://images.pexels.com/photos/6320/smartphone-vintage-technology-music.jpg?auto=compress&cs=tinysrgb&dpr=1&w=500',

  )
];
final moodList = [
  //0
  Moods(
      title: 'Happy',
      color: Colors.red,
      image:
          'https://images.pexels.com/photos/4571219/pexels-photo-4571219.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    playlists: happyPlayList,
  ),
  //1
  Moods(
      title: 'Disgust',
      color: Colors.greenAccent,
      image:
          'https://images.pexels.com/photos/2479312/pexels-photo-2479312.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    playlists: disgustPlayList,  //angryPlayList
  ),
  //2
  Moods(
      title: 'Scared',
      color: Colors.blueGrey,
      image:
          'https://images.pexels.com/photos/3618362/pexels-photo-3618362.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    playlists: fearPlayList, //surprisePlayList
  ),
  //3
  Moods(
      title: 'Angry',
      color: Colors.pinkAccent,
      image:
          'https://images.pexels.com/photos/6966/abstract-music-rock-bw.jpg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    playlists: angryPlayList, //neutralPlayList
  ),
  //4
  Moods(
      title: 'Sad',
      color: Colors.amber,
      image:
          'https://images.pexels.com/photos/1389429/pexels-photo-1389429.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    playlists: sadPlayList,
  ),
  //5
  Moods(
      title: 'Surprised',
      color: Colors.blueAccent,
      image:
          'https://images.pexels.com/photos/1876279/pexels-photo-1876279.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    playlists: surprisePlayList, //fearPlayList
  ),
  //6
  Moods(
      title: 'Neutral',
      color: Colors.purpleAccent,
      image:
          'https://images.pexels.com/photos/6320/smartphone-vintage-technology-music.jpg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    playlists: neutralPlayList, //disgustPlayList
  ),
];

final locationPlayList = [
  Playlist(
    title: 'Happy',
    image: 'assets/playlistImage/happy_happy.png',
    shuffle: false,
    likes: '3.5M',
    song: '37i9dQZF1DX2x1COalpsUi',
  ),
  Playlist(
    title: 'Feelin Good',
    image: 'assets/playlistImage/feelin_good.png',
    shuffle: true,
    likes: '2.5M',
    song: '37i9dQZF1DX9XIFQuFvzM4',
  ),
  Playlist(
    title: 'Millenium Melodies',
    image: 'assets/playlistImage/millenium_melodies.png',
    shuffle: false,
    likes: '2.5M',
    song: '37i9dQZF1DX5yXx6e61fbM',
  ),
  Playlist(
    title: 'Millenium Melodies',
    image: 'assets/playlistImage/millenium_melodies.png',
    shuffle: false,
    likes: '2.5M',
    song: '37i9dQZF1DX5yXx6e61fbM',
  ),
  Playlist(
    title: 'Millenium Melodies',
    image: 'assets/playlistImage/millenium_melodies.png',
    shuffle: false,
    likes: '2.5M',
    song: '37i9dQZF1DX5yXx6e61fbM',
  ),
];

final tamilNaduPlayList =[
  Playlist(
    title: 'kollywood cream',
    image: 'assets/location/tamilNadu/kollywood_cream.png',
    song: '37i9dQZF1DX0TyiNWW7uUQ',
  ),
  Playlist(
    title: 'Romantic Yuvan',
    image: 'assets/location/tamilNadu/romantic_yuvan.png',
    song: '37i9dQZF1DX77cyxwVn2PH',
  ),
  Playlist(
    title: 'raaja  90s',
    image: 'assets/location/tamilNadu/raaja_90s.png',
    song: '37i9dQZF1DX7k1b9eIxnmB',
  ),
  Playlist(
    title: 'Rahman 90s',
    image: 'assets/location/tamilNadu/rahman_90s.png',
    song: '37i9dQZF1DX4Cmr6Ex5w24',
  ),
  Playlist(
    title: 'Top Hits',
    image: 'assets/location/tamilNadu/top_hits.png',
    song: '37i9dQZF1DX1i3hvzHpcQV',
  ),
];

final drivingModePlaylist =[
  Playlist(
    title: 'Driving Mode',
    song: '37i9dQZF1DX5q67ZpWyRrZ',
    image:
    'https://images.pexels.com/photos/6320/smartphone-vintage-technology-music.jpg?auto=compress&cs=tinysrgb&dpr=1&w=500',

  )
];
