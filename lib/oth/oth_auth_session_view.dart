// Session View
import 'package:flutter/material.dart';
import 'oth_api_service.dart';

class SessionView extends StatefulWidget {
  final user; 
  SessionView({this.user});
  @override
  State<StatefulWidget> createState() {
    return SessionViewState();
  }
}

class SessionViewState extends State<SessionView> {
  String measurementId;
  final _dataserive = DataServie();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Authenticated ${widget.user.username}"),
        actions: [
          IconButton(
            onPressed: () async {
              print("load measurement id from OTH");
              final ids = await _dataserive.getOthMeasurementId();
              print(ids.toString());
              setState(() {
                measurementId = ids.toString();
              });
            },
            icon: Icon(Icons.download_sharp))
        ],
        ),
      body: Column(children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              measurementId == null ? Text("${widget.user.userId}") : Text(measurementId),
            ],),
          ),
        )
      ],),
    );
    
  }
}