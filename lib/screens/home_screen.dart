import 'package:flutter/material.dart';
import 'package:mumotionplayer/constants.dart';
import 'package:mumotionplayer/models/playlist_model.dart';
import 'package:mumotionplayer/screens/tabs/switch_tab.dart';
import 'package:mumotionplayer/screens/tabs/search_tab.dart';
import 'package:mumotionplayer/screens/test_song.dart';
import 'package:mumotionplayer/screens/tabs/settings_tab.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  void initState() {
    // TODO: implement initState
  // print(widget.cameraMode);
    super.initState();
  }


  bool value;
  final List<Widget> _widgetOptions = <Widget>[
    SwitchTab(),
    SearchTab(),
    ProfileTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor:AppColors.styleColor.withOpacity(0.80),
          ),
          child: BottomNavigationBar(
            unselectedItemColor: Colors.black,
            iconSize: 30,
            unselectedFontSize: 10,
            selectedFontSize: 10,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text('Search'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            onTap: _onItemTapped,
          ),
        ));
  }
}
