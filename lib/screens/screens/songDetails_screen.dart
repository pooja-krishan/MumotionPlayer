import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumotionplayer/constants.dart';
import 'package:mumotionplayer/screens/screens/custom_widget.dart';
import 'package:mumotionplayer/screens/screens/progress_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:mumotionplayer/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
class SongDetailScreen extends StatefulWidget {
  final songs;
  final bool isPlaying;

  const SongDetailScreen({Key key, this.songs, this.isPlaying})
      : super(key: key);

  @override
  _SongDetailScreenState createState() => _SongDetailScreenState();
}

//class _DetailPageState extends State<DetailPage> {
class _SongDetailScreenState extends State<SongDetailScreen>
    with SingleTickerProviderStateMixin {
  var _value;
  AnimationController _controller;
  var isplay;
  bool _connected = false;

  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 250), vsync: this);
    _value = 0.9;
    setState(() {
      isplay = widget.isPlaying;
    });
    getAuthToken();
    super.initState();
  }

  String authToken;

  void getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      authToken = prefs.getString('token');
    });
    print("authtoken: ${authToken}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomWidget(
                  radius: true,
                  size: 50,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: AppColors.styleColor,
                  ),
                ),
                Text(
                  "PLAYING NOW",
                  style: TextStyle(
                      color: AppColors.styleColor, fontWeight: FontWeight.bold),
                ),
                CustomWidget(
                  size: 50,
                  onTap: () {
                    _settingModalBottomSheet(context,authToken,widget.songs.uri);
                  },
                  radius: true,
                  child: Icon(
                    Icons.menu,
                    color: AppColors.styleColor,
                  ),
                ),
              ],
            ),
          ),
          CustomWidget(
              image: widget.songs.album.images.first.url,
              networkImage: true,
              radius: true,
              size: MediaQuery.of(context).size.width * .8,
              borderWidth: 5,
              onTap: null),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              widget.songs.name,
              style: TextStyle(
                color: AppColors.styleColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                height: 2,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.songs.artists.map((a) => a.name).join(', '),
              style: TextStyle(
                color: AppColors.styleColor.withAlpha(90),
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ProgressWidget(
              value: _value,
              labelStart: "1.05",
              labelEnd: "3.50",
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomWidget(
                  size: 60,
                  radius: true,
                  onTap: () {
                    setState(() {
                      if (_value > .1) {
                        _value -= .1;
                      }
                    });
                  },
                  child: Icon(
                    Icons.skip_previous,
                    color: AppColors.styleColor,
                  ),
                ),
                CustomWidget(
                  size: 70,
                  radius: true,
                  onTap: () {
                    if (_controller.value == 0) {
                      _controller.forward();
                      setState(() {
                        isplay = false;
                      });
                      pause();
                    } else {
                      _controller.reverse();
                      setState(() {
                        isplay = true;
                      });
                      play(widget.songs.uri);
                    }
                    print(isplay);
                  },
                  child: AnimatedIcon(
                    icon: AnimatedIcons.pause_play,
                    progress: _controller,
                    color: isplay ? Colors.white : AppColors.styleColor,
                  ),
                  isActive: isplay,
                ),
                CustomWidget(
                  size: 60,
                  radius: true,
                  onTap: () {
                    setState(() {
                      if (_value < .9) {
                        _value += .1;
                      }
                    });
                  },
                  child: Icon(
                    Icons.skip_next,
                    color: AppColors.styleColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
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
    print('play');
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

void _settingModalBottomSheet(context,String authToken,String song) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(title: new Text('Happy'), onTap: () => {
                httpRequest(authToken,'1fEANyywTj2Bc6hToYLgRZ',song)
              }),
              new ListTile(title: new Text('Sad'), onTap: () => {
                httpRequest(authToken,'0CNW1mPyEYi77y1moZJHcv',song)
              }),
              new ListTile(title: new Text('Neutral'), onTap: () => {
                httpRequest(authToken,'3PIwEvGEVPcGc4uDMAEp99',song)
              }),
              new ListTile(title: new Text('Surprise'), onTap: () => {
                httpRequest(authToken,'4ct9TlKw8PkEaSfngZfqeI',song)
              }),
              new ListTile(title: new Text('Angry'), onTap: () => {
                httpRequest(authToken,'0aa8fSqp5latp6zqMaMAWH',song)
              }),
              new ListTile(title: new Text('Fear'), onTap: () => {
                httpRequest(authToken,'341LKfbpb6wjO04djs1O0g',song)
              }),
              new ListTile(title: new Text('Disgust'), onTap: () => {
                httpRequest(authToken,'3zGwoVxpoj5cU3emTajM2a',song)
              }),
            ],
          ),
        );
      });
}

void  httpRequest(String authToken,String playList,String song) async {
  var queryParams={
    'uris': song
  };
  var url1 =
  Uri.https('api.spotify.com', '/v1/playlists/${playList}/tracks',queryParams);

  // Await the http get response, then decode the json-formatted response.
  var response = await http.post(url1,headers: {
    HttpHeaders.acceptHeader:"application/json",
    HttpHeaders.contentTypeHeader:"application/json",
    HttpHeaders.authorizationHeader:'Bearer '+authToken
   // HttpHeaders.authorizationHeader:'Bearer BQBodErYocVICIKpVs_1KcpzrMMUIpe3v9iHkl9_linlt8XEYxpeWpQn6hqpV3NiwoGyQpjPn_8103EH1blnNYzlvcQTCrDnUvu8IUVDYwFyTVXmAAN0FS7lGrNzPU9Lp344F7W4FHf0hnRchCBbo6rnWfWvA2YHcVOaGkPSMzI97A_UMMMq98motSsnEMzROnuS1QNTXrZg9IgsNOz6ljNKXs6Ldw56j7fGlSORgj0eyDM25AKcJP6dx0A1HM7MZcwi215lW5jzTrARjLo_vGnScDXs1-I85mDtVSSOdmUT'
  });
  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print('Request failed with status: ${response.statusCode}.');
    print(response.body);
  }
}
