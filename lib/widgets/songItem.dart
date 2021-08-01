import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumotionplayer/helpers/SharedAxisPageRoute.dart';
import 'package:mumotionplayer/models/playlist_model.dart';
import 'package:mumotionplayer/models/song_model.dart';
import 'package:mumotionplayer/widgets/songDetailScreen.dart';

class SongItem extends StatelessWidget {
  final Playlist playlist;
  final  data;

  const SongItem({Key key, this.playlist, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // final route = SharedAxisPageRoute(
        //   page: SongDetailScreen(
        //     playlist: playlist,
        //     data: data,
        //   ),
        // );

        Navigator.push(context, MaterialPageRoute(builder: (context)=>SongDetailScreen(
          playlist: playlist,
          data: data,
        )));
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal:20,
          vertical: 20,
        ),
        child: Row(
          children: [
            Image.network(
              data.album.images.first.url,
              height: 45,
              width: 45,
            ),
         // Image.network('https://i.scdn.co/image/ab67616d0000b273ff9fedb09c09fea02a7108af',height: 45,width:45 ,),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      data.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color:  Color(0xFFFAFAFA),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      )
                  ),
                  Text(
                    data.artists.map((a) => a.name).join(', '),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color:  Color(0xFFFAFAFA),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width:10),
            SvgPicture.asset(
              'assets/icons/actions.svg',
              height: 20,
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
