import 'package:flutter/material.dart';

class ShowModalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: ModalHomePage(),
    );
  }
}

class ModalHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("ShowModal"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("ShowModal"),
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: MediaQuery.of(context).size.height - 100,
                    color: Colors.white,
                    child: Column(
                      children: [
                        ElevatedButton(
                          child: Text("Close Button"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
