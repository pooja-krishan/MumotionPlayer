import 'package:flutter/material.dart';
import 'package:mumotionplayer/constants.dart';
import 'package:mumotionplayer/models/playlist_model.dart';
import 'package:mumotionplayer/screens/screens/custom_widget.dart';
import 'package:mumotionplayer/screens/screens/songList_screen.dart';
import 'package:mumotionplayer/widgets/genrasWidget.dart';
import 'package:spotify/spotify.dart' as a;
import 'package:spotify/spotify.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  List<SongListData> listData = [];
  SongListData _songListData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.mainColor,
        child: ListView(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text(
                        "Search",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      clipBehavior: Clip.antiAlias,
                      child: GestureDetector(
                        onTap: () async {
                          var result = await showSearch<String>(
                            context: context,
                            delegate: CustomDelegate(),
                          );
                          searchSongs(result);
                        },
                        child: Container(
                          height: 55,
                          width: 380,
                          color: AppColors.mainColor.withOpacity(0.50),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                                Text(
                                  " Artists, ",
                                  style: TextStyle(
                                      color: Colors.grey[900],
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "songs, ",
                                  style: TextStyle(
                                      color: Colors.grey[900],
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "or podcasts",
                                  style: TextStyle(
                                      color: Colors.grey[900],
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  listData.isEmpty
                      ? Column(
                          children: [
                            GenreGridView(
                              genre: "Your top genre",
                              name1: "Hip Hop",
                              name2: "Pop",
                              name3: "Rock",
                              name4: "Bollywood",
                              color1: Colors.red,
                              color2: Colors.greenAccent,
                              color3: Colors.blueGrey,
                              color4: Colors.pinkAccent,
                              url1:
                                  "https://images.pexels.com/photos/4571219/pexels-photo-4571219.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                              url2:
                                  "https://images.pexels.com/photos/2479312/pexels-photo-2479312.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                              url3:
                                  "https://images.pexels.com/photos/3618362/pexels-photo-3618362.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                              url4:
                                  "https://images.pexels.com/photos/761963/pexels-photo-761963.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                            ),
                            GenreGridView(
                              genre: "Browse all",
                              name1: "At Home",
                              name2: "Punjabi",
                              name3: "Summer",
                              name4: "Romance",
                              color1: Colors.amber,
                              color2: Colors.blueAccent,
                              color3: Colors.purpleAccent,
                              color4: Colors.deepPurpleAccent,
                              url1:
                                  "https://images.pexels.com/photos/6966/abstract-music-rock-bw.jpg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                              url2:
                                  "https://images.pexels.com/photos/1389429/pexels-photo-1389429.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                              url3:
                                  "https://images.pexels.com/photos/1876279/pexels-photo-1876279.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                              url4:
                                  "https://images.pexels.com/photos/6320/smartphone-vintage-technology-music.jpg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                            ),
                          ],
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height,
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (_, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomWidget(
                                image: "${listData[index].imageUri}",
                                size: 120,
                                radius: false,
                                borderWidth: 5,
                                networkImage: true,
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SongListScreen(
                                              playlists: null,
                                              songOnly: true,
                                              listData: listData[index],
                                            ))),
                              ),
                            ),
                            itemCount: listData.length,
                          ),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void searchSongs(String text) async {
    final credentials = a.SpotifyApiCredentials(
        'b03453cc8eef42e5addab055ccf37105', '99fc4b647d0f49948b6e8edff98678d9');
    final spotify = a.SpotifyApi(credentials);
    var search = await spotify.search
        .get(text, market: 'In')
        .first(10)
        .catchError((err) => print((err as SpotifyException).message));
    search.forEach((pages) {
      pages.items.forEach((item) {
        if (item is PlaylistSimple) {
          _songListData = SongListData(
              imageUri: item.images[0].url,
              uri: item.uri,
              playListName: item.name);
          setState(() {
            listData.add(_songListData);
          });
        }
      });
    });
    var splitag = listData[0].uri.split(":");
    print(splitag[2]);
  }
}

List<dynamic> nouns = ['master','vada chennai', 'teddy', 'asuran','theri','ponmagal vandhal','darbar','naan sirithal','oh my kadavule','pattas'];

class CustomDelegate<T> extends SearchDelegate<T> {
  List<dynamic> data = nouns.take(100).toList();
  List<dynamic> emptyData=[];

  @override
  List<Widget> buildActions(BuildContext context) =>
      [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
      icon: Icon(Icons.chevron_left), onPressed: () => close(context, null));

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    var listToShow;
    if (query.isNotEmpty)
      listToShow =
          data.where((e) => e.contains(query) && e.startsWith(query)).toList();
    else
      listToShow = emptyData;

    return ListView.builder(
      itemCount: listToShow.length,
      itemBuilder: (_, i) {
        var noun = listToShow[i];
        return ListTile(
          title: Text(noun),
          onTap: () => close(context, noun),
        );
      },
    );
  }
}
