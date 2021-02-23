import 'package:flutter/material.dart';

class ListSwipe extends StatefulWidget {
  @override
  ListSwipeState createState() => ListSwipeState();
}

class ListSwipeState extends State<ListSwipe> {
  final items = List<String>.generate(20, (index) => "Item ${index + 1}");
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("ListSwipe"),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Dismissible(
                onDismissed: (direction) {
                  setState(() {
                    items.removeAt(index);
                  });
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text("$item dismissed")));
                },
                background: Container(
                  color: Colors.red,
                ),
                key: Key(item),
                child: ListTile(
                  title: Text('$item'),
                ));
          },
        ),
      ),
    );
  }
}

class GestureDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Gesture Demo"),
        ),
        body: GuestureButton(),
      ),
    );
  }
}

class GuestureButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        print("tap me");
        final snackBar = SnackBar(content: Text("Tap"));
        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: Center(
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Theme.of(context).buttonColor,
              borderRadius: BorderRadius.circular(8.0)),
          child: Text("My Button"),
        ),
      ),
    );
  }
}
