import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumotionplayer/models/playlist_model.dart';
import 'package:mumotionplayer/models/song_model.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class SongDetailScreen extends StatelessWidget {
  final Playlist playlist;

  final data;

  const SongDetailScreen({Key key, this.playlist, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment(0.0, 0.8),
              colors: [
                const Color.fromRGBO(181, 220, 227, 0.6),
                const Color.fromRGBO(181, 220, 227, 0),
              ],
            ),

          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              songDetailHeader(context,title:playlist.title),
              Expanded(child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height:100),
                    songDetailCoverImage(context,data: data),
                   // SizedBox(height: 20,),
                    songDetailControls(context,data: data),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget songDetailHeader(BuildContext context,{String title}){
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: SvgPicture.asset(
              'assets/icons/down_chevron.svg',
              height: 10,
              width: 10,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  'PLAYING FROM PLAYLIST',
                  style: TextStyle(
                    color: Color(0xFFAEAEAE),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Color(0xFFFAFAFA),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SvgPicture.asset(
            'assets/icons/actions.svg',
            height: 20,
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget songDetailCoverImage(BuildContext context,{var data}){
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Image.network(data.album.images.first.url)
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
    print('play');
  }

  Widget songDetailControls(BuildContext context,{var data}){
    return Container(
      padding: EdgeInsets.all(35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.name,
            style: TextStyle(
              color: Color(0xFFFAFAFA),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            data.artists.map((a) => a.name).join(', '),
            style: TextStyle(
              color: Color(0xFFAEAEAE),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height:25),
          Column(
            children: [
              Container(
                height: 4,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: Stack(
                    children: [
                      Container(
                        color: Color.fromRGBO(255, 255, 255, 0.1),
                      ),
                      Container(
                        width: 30,
                        color: Color(0xFFFAFAFA),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '0:10',
                    style: TextStyle(
                      color: Color(0xFFFAFAFA),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '1:49',
                    style: TextStyle(
                      color: Color(0xFFFAFAFA),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height:16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                'assets/icons/heart.svg',
                height: 18,
                width: 18,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/next.svg',
                      height: 18,
                      width: 18,
                    ),
                    SizedBox(width:16),
                    GestureDetector(
                      onTap:(){
                        play(data.uri);
                      },
                      child: Container(
                        height:40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFFFAFAFA),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/play.svg',
                            height: 24,
                            width: 24,
                            color: Color(0xFF121212),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width:16),
                    SvgPicture.asset(
                      'assets/icons/back.svg',
                      height: 18,
                      width: 18,
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                'assets/icons/minus_circle.svg',
                height: 20,
                width: 20,
              ),
            ],
          ),
          SizedBox(height:10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                'assets/icons/devices.svg',
                height: 18,
                width: 18,
                color: Color(0xFFAEAEAE),
              ),
              SvgPicture.asset(
                'assets/icons/share.svg',
                height: 18,
                width: 18,
              ),
            ],
          ),
        ],
      ),
    );
  }

}
