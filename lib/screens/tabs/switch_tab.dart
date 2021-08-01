import 'package:flutter/material.dart';
import 'package:mumotionplayer/screens/tabs/driving_tab.dart';
import 'package:mumotionplayer/screens/tabs/mood_tab.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mumotionplayer/screens/tabs/location_tab.dart';

class SwitchTab extends StatefulWidget {
  @override
  _MoodTabState createState() => _MoodTabState();
}

class _MoodTabState extends State<SwitchTab> {
  int switchValue;

  @override
  void initState() {
    // TODO: implement initState
    getLocationMood();
    super.initState();
  }


  void getLocationMood() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt('locationMood');
    if (value != null) {
      setState(() {
        switchValue = value;
      });
    }
   // print('1 second');
  }

  @override
  Widget build(BuildContext context) {
    switch (switchValue) {
      case 0:
        {
          return LocationTab();

        }
      case 1:
        {
          return DrivingTab();
        }
      case 2:
        {
          return MoodTab();
        }
      default:
        {
          return Center(child: CircularProgressIndicator());
        }
    }

  }
}
