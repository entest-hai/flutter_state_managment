import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class TestNetworkRequestApp extends StatefulWidget {
  @override 
  _TestNetworkRequestState createState() => _TestNetworkRequestState();
}

class _TestNetworkRequestState extends State<TestNetworkRequestApp> {
  Future<Album> futureAlbum;
  final sot = DataService();

  @override 
   Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Network Request"),),
        body: Center(
          child: FutureBuilder<Album>(
            future: sot.fetchAlbum(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.title);
              } else if (snapshot.hasError) {
                return Text('ERROR ${snapshot.error}');
              }

              // Default 
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  @override 
  void initState() {
    super.initState();
    futureAlbum = sot.fetchAlbum();
  }
}

class Album {
    final int userId; 
    final int id; 
    final String title; 

    Album({this.userId, this.id, this.title});

    factory Album.fromJson(Map<String, dynamic> json){
      return Album(
        userId: json['userId'],
        id: json['id'],
        title: json['title']
      );
    } 
}


class DataService {

  Future<Album> fetchAlbum() async {
    final response = await http.get(Uri.https('jsonplaceholder.typicode.com', 'albums/2'));
    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load album.");
    }
  }
}  



