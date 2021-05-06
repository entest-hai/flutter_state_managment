import 'package:flutter/material.dart';
import 'oth_api_service.dart';

class OthApiView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OthApiAppState();
  }
}

class _OthApiAppState extends State<OthApiView> {
  final _dataService = DataServie();
  String _response; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OTH API"),),
      body: Center(
        child: Builder(builder: (_){
          if (_response != null) {
            return Text(_response);
          } else {
            return ElevatedButton(
              child: Text("Make Request"),
              onPressed: _makeRequest,
            );
          }
        },),
      ),
    );
  }

  Future<void> _makeRequest() async {
    final response =  await _dataService.getOthToken();
    setState(() {
      _response = response;
    });
    print(response);
  }
}

