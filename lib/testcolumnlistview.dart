import 'package:flutter/material.dart';

class ColumnListApp extends StatelessWidget {
  final posts = List<String>.generate(100, (index) => "Message $index");
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("ColumnList"),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(posts[index]),
                    ),
                  );
                },
              ),
            )  
          ],
        ),
      ),
    );
  }
}

