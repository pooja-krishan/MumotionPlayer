import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumotionplayer/data/spotify_data.dart';
import 'package:mumotionplayer/models/playlist_model.dart';
import 'package:mumotionplayer/widgets/songItem.dart';
import 'package:spotify/spotify.dart' as a;

class PlaylistItemSong extends StatefulWidget {

  final Playlist data;

  const PlaylistItemSong({Key key, this.data}) : super(key: key);

  @override
  _PlaylistItemSongState createState() => _PlaylistItemSongState();
}

class _PlaylistItemSongState extends State<PlaylistItemSong> {

  Future<Iterable<a.Track>> tracks;
  var playlist;
  @override
  void initState() {
    // TODO: implement initState
    getSongs();
    Future.delayed(Duration(seconds: 1),()=>getSongs());
    super.initState();
  }

  List list=[];
  void getSongs()async{
    final credentials = a.SpotifyApiCredentials('b03453cc8eef42e5addab055ccf37105', '99fc4b647d0f49948b6e8edff98678d9');
    final spotify = a.SpotifyApi(credentials);
    var playlist = await spotify.playlists.getTracksByPlaylistId(widget.data.song);
    playlist.all().then((value){
     setState(() {
       list = value.toList();
     });
      // for(var name in value.toList()){
      // //print(name.album.images.first.url);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment(0.0, 0.2),
              colors: [
                const Color(0xFF4A7BA1),
                const Color.fromRGBO(158, 196, 209, 0),
              ],
            ),
          ),
          child: Stack(
            children: [
              playlistDetailHeader(context),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height:100),
                    playlistDetailCoverImageSection(context),
                    SizedBox(height:50),
                    playlistDetailSongs(context),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  Widget playlistDetailHeader(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          GestureDetector(
            onTap: (){
              print('jdjhd');
             Navigator.pop(context);
            },
            child: SvgPicture.asset(
              'assets/icons/arrow_left.svg',
              height: 20,
              width: 20,
            ),
          ),
          const Spacer(),
          SvgPicture.asset(
            'assets/icons/heart.svg',
            height: 20,
            width: 20,
          ),
          SizedBox(width: 20),
          SvgPicture.asset(
            'assets/icons/actions.svg',
            height: 20,
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget playlistDetailCoverImageSection(BuildContext context){
    return Column(
      children: [
        Image.asset(
          widget.data.image,
          height: 220,
          width: 220,
        ),
        SizedBox(height:30),
        Text(
          widget.data.title,
          style: TextStyle(
            color: Color(0xFFFAFAFA),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'BY SPOTIFY',
              style: TextStyle(
                color: Color(0xFFFAFAFA),
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 5),
            SvgPicture.asset(
              'assets/icons/dot.svg',
              height: 6,
              width: 6,
            ),
            SizedBox(width:5),
            Text(
              '${widget.data.likes} LIKES',
              style: TextStyle(
                color: Color(0xFFFAFAFA),
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: 40,
          width: 100,
          decoration: BoxDecoration(
            color: Color(0xFF1DB954),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              "PLAY",
              style: TextStyle(
                color: Color(0xFFFAFAFA),
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );

  }

  Widget playlistDetailSongs(BuildContext context){
    return list.isNotEmpty?Column(
      children: list.map((song) =>SongItem(
        playlist: widget.data,
        data: song,
      ) ).toList()
    ): Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 4.0,backgroundColor: Colors.green,)),
        SizedBox(width: 20,),
        Text('Fetching songs please wait..',style: TextStyle(
            fontSize: 14,
            color: Colors.white
        ),)
      ],
    );

  }

}
