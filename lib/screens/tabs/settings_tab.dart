import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mumotionplayer/constants.dart';
import 'package:mumotionplayer/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool _locationValue = false;
  bool _drivingValue = false;
  @override
  void initState() {
    // TODO: implement initState
    getLocationMood();
    super.initState();
  }

  void getLocationMood() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt('locationMood');
    if(value!=null && value==0){
      setState(() {
        _locationValue=true;
      });
    }else if(value!=null && value==1){
      setState(() {
        _drivingValue=true;
      });
    }
  }
  void setLocationMood(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('locationMood', value);
  }
  void setCameraMode(bool value)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('cameraMode', value);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      // appBar: AppBar(
      //   leading: Text(''),
      //   backgroundColor: AppColors.styleColor,
      //   title: Text('Settings'),
      // ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              color: AppColors.styleColor,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 30),
                child: Text(
                  "Settings",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            MergeSemantics(
              child: ListTile(
                title: Text('Location mode'),
                trailing: CupertinoSwitch(
                  value: _locationValue,
                  onChanged: (bool value) {
                    setState(() {
                      _locationValue = value;
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>HomePage()));

                      //print('location ${_locationValue}');
                      if(value==true){
                        setLocationMood(0);
                        setCameraMode(false);
                      }else if(_locationValue==false && _drivingValue ==false){
                        setLocationMood(2);
                        setCameraMode(true);
                      }

                      value=!value;
                    });
                  },
                ),
              ),
            ),
            MergeSemantics(
              child: ListTile(
                title: Text('Driving mode'),
                trailing: CupertinoSwitch(
                  value: _drivingValue,
                  onChanged: (bool value) {
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>HomePage()));
                      _drivingValue = value;
                     // print('Driving ${_drivingValue}');
                      if(value==true){
                        setLocationMood(1);
                        setCameraMode(false);
                      }else if(_locationValue==false && _drivingValue ==false){
                        setLocationMood(2);
                        setCameraMode(true);
                      }
                      value=!value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
