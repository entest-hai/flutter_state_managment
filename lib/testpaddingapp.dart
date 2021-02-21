import 'package:flutter/material.dart';

class TestPaddingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: TestPaddingAppHomePage(),
    );
  }
}

class TestPaddingAppHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [Colors.blue[800], Colors.blue[200]])),
        child: Padding(
          padding: EdgeInsets.all(100.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.red,
                child: Text("OK"),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.grey,
                  child: Text("OK"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
