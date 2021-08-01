
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Bottom sheet'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          _settingModalBottomSheet(context);
        },
        child: new Icon(Icons.add),
      ),
    );
  }
}

void _settingModalBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                  title: new Text('Happy'),
                  onTap: () => {
                    httpRequest()
                  }
              ),
              new ListTile(
                  title: new Text('Sad'),
                  onTap: () => {}
              ),
              new ListTile(
                  title: new Text('Neutral'),
                  onTap: () => {}
              ),
              new ListTile(
                  title: new Text('Surprise'),
                  onTap: () => {}
              ),
              new ListTile(
                  title: new Text('Angry'),
                  onTap: () => {}
              ),
              new ListTile(
                  title: new Text('Fear'),
                  onTap: () => {}
              ),
              new ListTile(
                  title: new Text('Disgust'),
                  onTap: () => {}
              ),
            ],
          ),
        );
      });
}

// void httpRequest()async{
//   var client = http.Client();
//   try {
//     var uriResponse = await client.post('https://example.com/whatsit/create',
//         body: {'name': 'doodle', 'color': 'blue'});
//     print(uriResponse.body);
//   } finally {
//   client.close();
//   }
// }

void  httpRequest() async {
  var queryParams={
    'uris':'spotify:track:1baHxgYktT8eDdmtTozJF9'
  };
  var url1 =
  Uri.https('api.spotify.com', '/v1/playlists/30PV7uuGrPR4aRvwtO8m82/tracks',queryParams);

  // Await the http get response, then decode the json-formatted response.
  var response = await http.post(url1,headers: {
    HttpHeaders.acceptHeader:"application/json",
    HttpHeaders.contentTypeHeader:"application/json",
    HttpHeaders.authorizationHeader:
        "BQBk3D6uScpfuh1clIHJ4LfV0tZONFKOk2SM86L6QPOY8N0viZ9lkjDYxARw8iIpabdPpbkGe1GPeG0dvaIhMPfhLS_L9A0z1eucC-5eQavv2FyWnbDJT92fiYPwK6Lln5jkbxt6-1UBX4wYp917W77oiC7t5TgWBmFT1IpkQP3cMfpujUFUrwQ8P8aAKatG8j0tsRNNuFZ6HXZk_6xT4AKpF6i8AcxUW8tpApImqf92XcaWmdxEZAGuUurM5jrU3nWvvCyHf9BupcnzG7EypVAihzoH3vqcs-sXnuSSMwNy"
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