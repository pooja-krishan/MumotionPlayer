import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumotionplayer/data/spotify_data.dart';
import 'package:mumotionplayer/homePage.dart';
import 'package:mumotionplayer/models/playlist_model.dart';
import 'package:mumotionplayer/widgets/sized_icon_button.dart';
import 'package:spotify/spotify.dart';
import 'package:spotify_sdk/models/library_state.dart';
import 'package:spotify_sdk/models/player_context.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:logger/logger.dart';
import 'package:spotify/spotify.dart' as a;
import 'package:http/http.dart' as http;
import 'dart:io';

class TestSong extends StatefulWidget {
  @override
  _TestSongState createState() => _TestSongState();
}

class _TestSongState extends State<TestSong> {
  final Logger _logger = Logger();
  bool _loading = false;
  bool _connected = false;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _sampleFlowWidget(context),
    );
  }

  Widget _sampleFlowWidget(BuildContext context2) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(8),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FlatButton(
                    onPressed: connectToSpotifyRemote,
                    child: Container(
                      child: Text('Remote'),
                    ),
                    shape: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            width: 0.0,
                            color: Theme.of(context).accentColor),
                        borderRadius: new BorderRadius.circular(20.0)),
                    color: Colors.blue,
                  ),
                  FlatButton(
                    onPressed: disconnect,
                    child: Container(
                      child: Text('Disconnect'),
                    ),
                    shape: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            width: 0.0,
                            color: Theme.of(context).accentColor),
                        borderRadius: new BorderRadius.circular(20.0)),
                    color: Colors.blue,
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedIconButton(
                    width: 50,
                    icon: Icons.skip_previous,
                    onPressed: skipPrevious,
                  ),
                  SizedIconButton(
                    width: 50,
                    icon: Icons.play_arrow,
                    onPressed: resume,
                  ),
                  SizedIconButton(
                    width: 50,
                    icon: Icons.pause,
                    onPressed: pause,
                  ),
                  SizedIconButton(
                    width: 50,
                    icon: Icons.skip_next,
                    onPressed: skipNext,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedIconButton(
                    width: 50,
                    icon: Icons.play_circle_filled,
                    onPressed: play,
                  ),

                ],
              ),
              FlatButton(onPressed: getAuthenticationToken, child: Text('Auth'),color: Colors.red,),

              FlatButton(
                onPressed: httpRequest,
                child: Text('Http'),
                color: Colors.blue,
              ),
            ],
          ),
          _loading
              ? Container(
                  color: Colors.black12,
                  child: const Center(child: CircularProgressIndicator()))
              : const SizedBox(),
        ],
      ),
    );
  }

  void addToLibrary()async{
    final credentials = a.SpotifyApiCredentials(
        'b03453cc8eef42e5addab055ccf37105', '99fc4b647d0f49948b6e8edff98678d9');
    final spotify = a.SpotifyApi(credentials);
    var search = await spotify.search
        .get('master')
        .first(2)
        .catchError((err) => print((err as SpotifyException).message));
    if (search == null) {
      return;
    }
    search.forEach((pages) {
      pages.items.forEach((item) {
        if (item is PlaylistSimple) {
          print('Playlist: \n'
              'id: ${item.id}\n'
              'name: ${item.name}:\n'
              'collaborative: ${item.collaborative}\n'
              'href: ${item.href}\n'
              'trackslink: ${item.tracksLink.href}\n'
              'owner: ${item.owner}\n'
              'public: ${item.owner}\n'
              'snapshotId: ${item.snapshotId}\n'
              'type: ${item.type}\n'
              'uri: ${item.uri}\n'
              'images: ${item.images.length}\n'
              '-------------------------------');
        }
        if (item is Artist) {
          print('Artist: \n'
              'id: ${item.id}\n'
              'name: ${item.name}\n'
              'href: ${item.href}\n'
              'type: ${item.type}\n'
              'uri: ${item.uri}\n'
              '-------------------------------');
        }
        if (item is TrackSimple) {
          print('Track:\n'
              'id: ${item.id}\n'
              'name: ${item.name}\n'
              'href: ${item.href}\n'
              'type: ${item.type}\n'
              'uri: ${item.uri}\n'
              'isPlayable: ${item.isPlayable}\n'
              'artists: ${item.artists.length}\n'
              'availableMarkets: ${item.availableMarkets.length}\n'
              'discNumber: ${item.discNumber}\n'
              'trackNumber: ${item.trackNumber}\n'
              'explicit: ${item.explicit}\n'
              '-------------------------------');
        }
        if (item is AlbumSimple) {
          print('Album:\n'
              'id: ${item.id}\n'
              'name: ${item.name}\n'
              'href: ${item.href}\n'
              'type: ${item.type}\n'
              'uri: ${item.uri}\n'
              'albumType: ${item.albumType}\n'
              'artists: ${item.artists.length}\n'
              'availableMarkets: ${item.availableMarkets.length}\n'
              'images: ${item.images.length}\n'
              'releaseDate: ${item.releaseDate}\n'
              'releaseDatePrecision: ${item.releaseDatePrecision}\n'
              '-------------------------------');
        }
      });
    });
  }

  void setStatus(String code, {String message = ''}) {
    var text = message.isEmpty ? '' : ' : $message';
    print('$code$text');
  }

  Future<void> connectToSpotifyRemote() async {
    try {
      setState(() {
        _loading = true;
      });
      var result = await SpotifySdk.connectToSpotifyRemote(
          clientId: 'b03453cc8eef42e5addab055ccf37105',
          //b03453cc8eef42e5addab055ccf37105
          redirectUrl:
              'http://com.example.mumotionplayer/callback'); //http://com.example.mumotionplayer/callback
      setStatus(result
          ? 'connect to spotify successful'
          : 'connect to spotify failed');
      setState(() {
        _loading = false;
      });
    } on PlatformException catch (e) {
      setState(() {
        _loading = false;
      });
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setState(() {
        _loading = false;
      });
      setStatus('not implemented');
    }
  }

  Future<void> disconnect() async {
    try {
      setState(() {
        _loading = true;
      });
      var result = await SpotifySdk.disconnect();
      setStatus(result ? 'disconnect successful' : 'disconnect failed');
      setState(() {
        _loading = false;
      });
    } on PlatformException catch (e) {
      setState(() {
        _loading = false;
      });
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setState(() {
        _loading = false;
      });
      setStatus('not implemented');
    }
  }

  Future<void> play() async {
    try {
      await SpotifySdk.play(spotifyUri: 'spotify:track:4GC2IwmYrlC12YfPfHPLQe');

    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> pause() async {
    try {
      await SpotifySdk.pause();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> resume() async {
    try {
      await SpotifySdk.resume();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> skipNext() async {
    try {
      await SpotifySdk.skipNext();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> skipPrevious() async {
    try {
      await SpotifySdk.skipPrevious();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  void getAlbum() async {
    final credentials = SpotifyApiCredentials(
        'b03453cc8eef42e5addab055ccf37105', '99fc4b647d0f49948b6e8edff98678d9');
    final spotify = SpotifyApi(credentials);
    var playlist =
        await spotify.playlists.getTracksByPlaylistId('37i9dQZF1DWURwnI16u16C');
    Iterable<Track> tracks;
    playlist.all().then((value) {
      tracks = value;
      print(tracks.first.name);
    });
  }

  void getSong() {
    //getSongApi();
    Future<Iterable<Track>> tracks = getSongApi();
    tracks.then((value) => print(value.first.name));
  }


  var authKey;
  void  httpRequest() async {
    var queryParams={
      'uris':'spotify:track:5b7Px47PuvYFg2wjgymcRH'
    };
    var url1 =
    Uri.https('api.spotify.com', '/v1/playlists/30PV7uuGrPR4aRvwtO8m82/tracks',queryParams);
    // Uri.https('api.spotify.com', '/v1/playlists/30PV7uuGrPR4aRvwtO8m82/tracks',queryParams);

    // Await the http get response, then decode the json-formatted response.
    var response = await http.post(url1,headers: {
      HttpHeaders.acceptHeader:"application/json",
      HttpHeaders.contentTypeHeader:"application/json",
      HttpHeaders.authorizationHeader:'Bearer '+authKey
    });
    print(url1);
    if (response.statusCode == 200) {
      print(response.body);
      // var jsonResponse = convert.jsonDecode(response.body);
      // var itemCount = jsonResponse['totalItems'];
      // print('Number of books about http: $itemCount.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print(response.body);
    }
  }


  Future<String> getAuthenticationToken() async {
    try {
      var authenticationToken = await SpotifySdk.getAuthenticationToken(
          clientId: 'b03453cc8eef42e5addab055ccf37105', //DotEnv().env['CLIENT_ID'].toString()
          redirectUrl: 'http://com.example.mumotionplayer/callback', //DotEnv().env['REDIRECT_URL'].toString()
          scope: 'app-remote-control, '
              'user-modify-playback-state, '
              'playlist-read-private, '
              'playlist-modify-public,playlist-modify-private,user-read-currently-playing');
      var result = await SpotifySdk.connectToSpotifyRemote(
          clientId: 'b03453cc8eef42e5addab055ccf37105',
          //b03453cc8eef42e5addab055ccf37105
          redirectUrl:
          'http://com.example.mumotionplayer/callback'); //http://com.example.mumotionplayer/callback
      setStatus(result
          ? 'connect to spotify successful'
          : 'connect to spotify failed');
      setState(() {
        authKey=authenticationToken;
      });
      setStatus('Got a token: $authenticationToken');
      //Navigator.pushReplacementNamed(context, '/testSong');
     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>HomePage()));
      return authenticationToken;
    } on PlatformException catch (e) {
      print("platformException");
      setStatus(e.code, message: e.message);
      return Future.error('$e.code: $e.message');
    } on MissingPluginException {
      print("MissingPluginException");
      setStatus('not implemented');
      return Future.error('not implemented');
    }
  }
}
