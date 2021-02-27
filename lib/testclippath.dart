import 'dart:convert';

import 'package:flutter/material.dart';

class ClipPathApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Living Room Air Purifier"),
          ),
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      height: 310,
                      decoration: ShapeDecoration(
                          shape: CircleBorder(),
                          color: Color.fromRGBO(232, 242, 231, 1.0)),
                    ),
                    Container(
                      height: 280,
                      decoration: ShapeDecoration(
                          shape: CircleBorder(),
                          color: Color.fromRGBO(195, 231, 175, 1.0)),
                    ),
                    Container(
                      height: 250,
                      decoration: ShapeDecoration(
                          shape: CircleBorder(),
                          color: Color.fromRGBO(106, 191, 74, 1.0)),
                    ),
                    Column(
                      children: [
                        Spacer(),
                        Text(
                          "1 ppb (mg/m3)",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Text(
                          '001',
                          style: TextStyle(
                              fontSize: 55,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        ),
                        Text(
                          'Air Indoor is Excellent',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Spacer()
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Text(
                          "72",
                          style: TextStyle(fontSize: 55),
                        ),
                        Text(
                          "Temperature (F)",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    child:
                        VerticalDivider(thickness: 2.5, color: Colors.orange),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Text(
                          "60%",
                          style: TextStyle(fontSize: 55),
                        ),
                        Text(
                          "Humidity (%)",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Spacer(),
                    Container(
                      width: 350,
                      height: 150,
                      color: Colors.blue.withOpacity(0.5),
                      child: Center(
                        child: Text("Chart"),
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.green[200].withOpacity(0.5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.person,
                              size: 50,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.green[200].withOpacity(0.5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.lightbulb,
                              size: 50,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.green[200].withOpacity(0.5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.ac_unit,
                              size: 50,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.green[200].withOpacity(0.5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.camera,
                              size: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
