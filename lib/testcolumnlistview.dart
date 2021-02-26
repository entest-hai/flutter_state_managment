import 'package:flutter/material.dart';

class ColumnListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("ColumnList"),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey,
                  child: Text("Definition"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
