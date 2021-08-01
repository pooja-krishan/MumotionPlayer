import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumotionplayer/constants.dart';
import 'package:mumotionplayer/models/playlist_model.dart';
import 'package:mumotionplayer/screens/screens/custom_widget.dart';
import 'package:mumotionplayer/screens/screens/songDetails_screen.dart';
import 'package:spotify/spotify.dart' as a;
import 'package:spotify_sdk/spotify_sdk.dart';

class SongListScreen extends StatefulWidget {
  final Playlist playlists;
  final bool songOnly;
  final bool assetOnly;
  final SongListData listData;
  const SongListScreen({Key key, this.playlists,this.songOnly,this.listData,this.assetOnly}) : super(key: key);
  @override
  _SongListScreenState createState() => _SongListScreenState();
}

class _SongListScreenState extends State<SongListScreen> {
  int _playId=0;
  Future<Iterable<a.Track>> tracks;
  bool isPlaying=false;
  @override
  void initState() {
    getSongs();
    //setupAlan();
    super.initState();
  }

  List songListFromApi = [];

  void getSongs() async {
    final credentials = a.SpotifyApiCredentials(
        'b03453cc8eef42e5addab055ccf37105', '99fc4b647d0f49948b6e8edff98678d9');
    final spotify = a.SpotifyApi(credentials);
    var splitag = widget.songOnly?widget.listData.uri.split(":"):[];
    var playlist = await widget.songOnly?spotify.playlists.getTracksByPlaylistId(splitag[2]):spotify.playlists.getTracksByPlaylistId(widget.playlists.song);
    playlist.all().then((value) {
      setState(() {
        songListFromApi = value.toList();
      });
      play(songListFromApi[0].uri);
    });
  }
  // setupAlan(){
  //   // AlanVoice.addButton(
  //   //     "67d82ca69d68c9b7aa9636ed9d66020d2e956eca572e1d8b807a3e2338fdd0dc/stage",
  //   //     buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT);
  //   AlanVoice.callbacks.add((command) =>_handleCommand(command.data));
  // }
  _handleCommand(Map<String,dynamic> response){
    print('command');
    print(response['command']);
    switch(response['command']){
      case "play":
        play(songListFromApi[0].uri);
        break;
      default:
        print("Command was ${response["command"]}");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title:widget.songOnly? Text(
         widget.listData.playListName,
          style: TextStyle(color: AppColors.styleColor),
        ):Text(
          widget.playlists.title,
          style: TextStyle(color: AppColors.styleColor),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CustomWidget(
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.styleColor,
                      ),
                      size: 50,
                      radius: true,
                      onTap: () {},
                    ),
                    widget.songOnly?CustomWidget(
                      image: "${widget.listData.imageUri}",
                      size: 175,
                      borderWidth: 5,
                      radius: true,
                      networkImage: true,
                      onTap: null,
                    ):CustomWidget(
                      image: "${widget.playlists.image}",
                     // image: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.safe2drive.com%2F&psig=AOvVaw0DhCVZwaJs1yvsvjL3NUr5&ust=1615965684161000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCODHubmjtO8CFQAAAAAdAAAAABAJ",
                      size: 175,
                      borderWidth: 5,
                      radius: true,
                    networkImage: widget.assetOnly?false:true,
                      onTap: null,
                    ),
                    CustomWidget(
                      child: Icon(
                        Icons.menu,
                        color: AppColors.styleColor,
                      ),
                      radius: true,
                      size: 50,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: songListFromApi.length,
                  padding: EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    //  print(songListFromApi[0].album.images.first.url);
                    return songListFromApi.isNotEmpty?GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => SongDetailScreen(
                              songs: songListFromApi[index],
                              isPlaying: !isPlaying,
                            ),
                          ),
                        );
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        decoration: BoxDecoration(
                          color: index == _playId
                              ? AppColors.activeColor
                              : AppColors.mainColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CustomWidget(
                              onTap: null,
                              networkImage:true,
                              image:songListFromApi[index].album.images.first.url,
                              size: 54,
                              radius: true,
                              borderWidth: 3,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    songListFromApi[index].name,
                                    style: TextStyle(
                                      color: AppColors.styleColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    songListFromApi[index].artists.map((a) => a.name).join(', '),
                                    style: TextStyle(
                                      color: AppColors.styleColor.withAlpha(100),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CustomWidget(
                              radius: true,
                              child: Icon(
                                index == _playId
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: index == _playId
                                    ? Colors.white
                                    : AppColors.styleColor,
                              ),
                              size: 50,
                              onTap: () {
                                setState(() {
                                  if(!isPlaying){
                                    isPlaying=true;
                                    _playId=null;
                                    pause();
                                  }else{
                                    isPlaying=false;
                                    _playId = index;
                                    play(songListFromApi[_playId].uri);
                                  }
                                });
                              },
                              isActive: index == _playId,
                            )
                          ],
                        ),
                      ),
                    ):Center(
                      child: Text('fetching songs from api please wait...',style: TextStyle(
                        color: Colors.black
                      ),),
                    );
                  },
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }


  Future<void> play(String track) async {
    try {
      await SpotifySdk.play(spotifyUri: track);
    } on PlatformException catch (e) {
      print(e.code);
      print(e.message);
    } on MissingPluginException {
      print('not implemented');
    }
  }

  Future<void> pause() async {
    try {
      await SpotifySdk.pause();
    } on PlatformException catch (e) {
      print(e.code);
      print(e.message);
    } on MissingPluginException {
      print('not implemented');
    }
  }
}
