import 'package:flutter/material.dart';
import 'package:mumotionplayer/data/playlists.dart';
import 'package:mumotionplayer/screens/screens/songList_screen.dart';
import 'package:mumotionplayer/models/tflite_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoodTab extends StatefulWidget {

  @override
  _MoodTabState createState() => _MoodTabState();
}

class _MoodTabState extends State<MoodTab> {
  Map<String, double> predictions = Map<String, double>();

  TFLITEPredictions _tflitePredictions = TFLITEPredictions();
  String moods = '';
  bool value=false;
  //
  @override
  void initState() {
    // TODO: implement initState
    getCameraMode();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    setCameraMode();
    super.dispose();
  }
  void setCameraMode()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('cameraMode', false);
  }
  void getCameraMode()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
   setState(() {
     value =prefs.getBool('cameraMode');
   });
   if(value ==true){
     getData();
   }
  }

  void navigationToPlaylist(int id){
    print('id: ${id}');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SongListScreen(
              playlists: moodList[id].playlists[0],
              songOnly: false,
              assetOnly: false,
              listData: null,
            )));
    setState(() {
   //   counter = counter+1;
      imageProcessing=false;
    });
  }
 // int counter =0;
  bool imageProcessing=false;
  void getData() async {
    Future.delayed(Duration(seconds: 2),(){
      setState(() {
        imageProcessing=true;
      });
    });
    _tflitePredictions.loadTFliteModel();
     predictions = await _tflitePredictions.predict();
    setState(() {
      moods = predictions.entries.first.key;
    });
    // 0 - happy
    // 1 - disgust
    // 2 - scared
    // 3 - angry
    // 4 - sad
    // 5 - surprise
    // 6 - neutral

    // navigationToPlaylist(3);


    // if(counter==3){
    //   setState(() {
    //     counter=0;
    //   });
    //   navigationToPlaylist(counter);
    // }else{
    //   navigationToPlaylist(counter);
    // }


    if (moods.trim().compareTo('happy') == 0) {
     navigationToPlaylist(0);
    } else if (moods.trim().compareTo('disgust') == 0) {
      navigationToPlaylist(1);
    } else if (moods.trim().compareTo('scared') == 0) {
      navigationToPlaylist(2);
    } else if (moods.trim().compareTo('angry') == 0) {
      navigationToPlaylist(3);
    } else if (moods.trim().compareTo('sad') == 0) {
      navigationToPlaylist(4);
    } else if (moods.trim().compareTo('surprised') == 0) {
      navigationToPlaylist(5);
    } else if (moods.trim().compareTo('neutral') == 0) {
      navigationToPlaylist(6);
    }

  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Container(
          child: Column(
            children: [
              Container(
                height: 80,
                color: Colors.blue,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        "Mood",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0, top: 18.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          size: 35,
                        ),
                        color: Colors.white,
                        onPressed:  getData,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: GridView.builder(
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (_, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SongListScreen(
                                playlists: moodList[index].playlists[0],
                                songOnly: false,
                                assetOnly: false,
                                listData: null,
                              )));
                    },
                    child: Card(
                      margin: const EdgeInsets.only(
                        left: 20.0,
                        right: 18,
                        bottom: 30.0,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                        color: moodList[index].color,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                moodList[index].title,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 34.0),
                              child: RotationTransition(
                                turns: AlwaysStoppedAnimation(15 / 360),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: SizedBox(
                                    height: 120,
                                    width: 120,
                                    child: Image.network(moodList[index].image),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  itemCount: moodList.length,
                ),
              ),
            ],
          ),
        ),
        imageProcessing?Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              color: Colors.black,
              child: Row(
                children: [
                  SizedBox(width: 20,),
                  Text('Predicting emotion. Please wait...',style: TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: 16
                  ),),
                  SizedBox(width: 20,),
                  Container(
                  //  margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                    //    backgroundColor: Colors.red,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.yellowAccent),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ):Container()
      ],
    );
  }
}
