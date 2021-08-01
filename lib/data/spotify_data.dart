import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';

Future<Iterable<Track>> getSongApi() async {
  final credentials = SpotifyApiCredentials('b03453cc8eef42e5addab055ccf37105', '99fc4b647d0f49948b6e8edff98678d9');
  final spotify = SpotifyApi(credentials);
  final playlist = await spotify.playlists.getTracksByPlaylistId('37i9dQZF1DWURwnI16u16C');
  //Iterable<Track> tracks;
  return playlist.all();
  // playlist.all().then((value){
  //   tracks=value;
  //   //print(tracks.first.name);
  // });
  // return tracks;
 // return tracks.first.name;
}