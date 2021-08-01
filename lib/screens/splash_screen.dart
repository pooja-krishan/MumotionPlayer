import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mumotionplayer/homePage.dart';
import 'package:mumotionplayer/screens/home_screen.dart';
import 'package:mumotionplayer/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getLogin();
    super.initState();
    startTime();
  }
  bool _loggedIn=false;
  void getLogin()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _loggedIn= prefs.getBool('loggedIn');
      print(_loggedIn);
    });
  }
  startTime() async {
    var duration = new Duration(seconds: 2);
    return new Timer(duration, route);
  }
  route() async{
  // Navigator.pushReplacementNamed(context, '/loginScreen');
    if(_loggedIn==true){
      var result = await SpotifySdk.connectToSpotifyRemote(
          clientId: 'b03453cc8eef42e5addab055ccf37105',
          //b03453cc8eef42e5addab055ccf37105
          redirectUrl:
          'http://com.example.mumotionplayer/callback'); //http://com.example.mumotionplayer/callback
      print(result
          ? 'connect to spotify successful'
          : 'connect to spotify failed');
      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2cc5e4),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset("assets/logo.png"),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text(
              "Mumotion Player",
              style: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xfffe674a)
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 1,
            )
          ],
        ),
      ),
    );
  }
}
