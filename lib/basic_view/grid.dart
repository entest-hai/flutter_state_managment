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
  List<_Photo> _photos(){
    return [
      _Photo(assetName: "assets/images/tokyo1.jpeg",title: "tokyo",subtitle: "shybuya"),
      _Photo(assetName: "assets/images/tokyo2.jpeg",title: "tokyo",subtitle: "shybuya"),
      _Photo(assetName: "assets/images/tokyo3.jpeg",title: "tokyo",subtitle: "shybuya"),
      _Photo(assetName: "assets/images/tokyo4.jpeg",title: "tokyo",subtitle: "shybuya"),
      _Photo(assetName: "assets/images/tokyo.jpeg",title: "tokyo",subtitle: "shybuya"),
      _Photo(assetName: "assets/images/tokyo.jpeg",title: "tokyo",subtitle: "shybuya"),
      _Photo(assetName: "assets/images/tokyo.jpeg",title: "tokyo",subtitle: "shybuya"),
      _Photo(assetName: "assets/images/tokyo.jpeg",title: "tokyo",subtitle: "shybuya")
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GridItems"),
      ),
      body:GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: const EdgeInsets.all(8),
        childAspectRatio: 1,
        children: _photos().map<Widget>((photo){
            return _GridDemoPhotoItem(photo: photo,);
          }).toList()
      ),
    );
  }
}


class _GridDemoPhotoItem extends StatelessWidget {
  const _GridDemoPhotoItem({
    Key key,
    @required this.photo,
  }) : super(key: key);

  final _Photo photo;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Image.asset(
        this.photo.assetName,
        fit: BoxFit.cover
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