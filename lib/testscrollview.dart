import 'package:flutter/material.dart';

class FoodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: FoodAppHomePage(),
    );
  }
}

class FoodAppHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Food"),
      ),
      body: Column(
        children: [
          CategoriesScroller(),
          Container(
            height: 200,
            child: ListItemView(),
          ),
          Expanded(
            child: ListItemBuilder(),
          )
        ],
      ),
    );
  }
}

// SingleSchildScrollView with For Loop
// Low performance when rendering all items
class CategoriesScroller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: cards(),
      ),
    );
  }

  //
  Widget Card(Color color) {
    return Container(
      width: 150,
      height: 200,
      color: color,
    );
  }

  //
  List<Widget> cards() {
    return [
      Card(Colors.grey),
      Card(Colors.green),
      Card(Colors.blue),
      Card(Colors.yellow),
      Card(Colors.red),
      Card(Colors.purple)
    ];
  }
}

// ListView with Builder from Data
class ListItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: [
        CardItem("HaiTran"),
        CardItem("HaTran"),
        CardItem("MinhTran"),
        CardItem("Due Mike"),
        CardItem("Galy Dok")
      ],
    );
  }

  // Card Item
  Widget CardItem(String name) {
    return Card(
      child: ListTile(
        title: Text(name),
      ),
    );
  }
}

// ListViewBuilder
class ListItemBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemCount: names.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(names[index].toUpperCase()),
            ),
          );
        });
  }

  // Data
  List<String> names = [
    "HaiTran",
    "MinhTran",
    "HaTran",
    "Mike Due",
    "Sami Diael",
    "Michale San",
    "Peter Mou",
    "HaiTran",
    "MinhTran",
    "HaTran",
    "Mike Due",
    "Sami Diael",
    "Michale San",
  ];
}
