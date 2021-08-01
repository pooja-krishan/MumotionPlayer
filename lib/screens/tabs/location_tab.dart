import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mumotionplayer/screens/screens/playlist_screen.dart';
import 'package:mumotionplayer/data/playlists.dart';
class LocationTab extends StatefulWidget {
  @override
  _LocationTabState createState() => _LocationTabState();
}

class _LocationTabState extends State<LocationTab> {
  @override
  void initState() {
    // TODO: implement initState
    getLocation();
    super.initState();
  }
  var state;
  var country;

  void getLocation() async {
    await Geolocator.getCurrentPosition().then((value) async => {
        //  print("lat ${value.latitude}, long ${value.longitude}"),
          _locationAddress(value.latitude, value.longitude),
        });
  }

  void _locationAddress(double lat, double lang) async {
    final coordinates = new Coordinates(lat, lang);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    setState(() {
      state=first.adminArea;
      country=first.countryName;
    });
   // print("${first.countryName}");
   // print("${first.adminArea}");
  }

  @override
  Widget build(BuildContext context) {
   // print('location tab');
    if(state!=null && country!=null){
      if(country == 'India'){
        //Tamil Nadu
        //India
        //United States
        //California
        if(state == 'Tamil Nadu'){
          return Container(
            child: PlayListScreen(playlists: tamilNaduPlayList,title: 'Location',live: true,),
          );
        }else if(state == 'Andhra pradesh'){
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text('Hello Andhra pradesh'),
                ),
              ],
            ),
          );
        }else{
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text('out of three states'),
                ),
              ],
            ),
          );
        }
      }
      else{
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text('Out of india'),
              ),
            ],
          ),
        );
      }
    }else{
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

  }
}
