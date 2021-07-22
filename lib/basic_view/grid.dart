import 'package:flutter/material.dart';

class GridApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GridListDemo(),
    );
  }
}


class GridListDemo extends StatelessWidget {
  const GridListDemo({Key key, this.type}) : super(key: key);
  final GridListDemo type; 

  // photos 
  List<String> _photos(){
    return [
      "Hello Hai Tran",
      "Hello Min Tran",
      "Hello Ha Tran"
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GridItems"),
      ),
      body:ListView(
        children: _photos().map<Widget>((photo) {
          return Card(
            child: ListTile(
              title: Text(photo)
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _Photo {
  _Photo({
    this.assetName,
    this.title,
    this.subtitle
  });
  final String assetName; 
  final String title; 
  final String subtitle; 
}