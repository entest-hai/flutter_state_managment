import 'package:flutter/material.dart';

class HistoricalCTGApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HistoricalCTGView());
  }
}

class HistoricalCTGView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HistoricalCTGState();
  }
}

class _HistoricalCTGState extends State<HistoricalCTGView> {
  var _selectedCard = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historical CTG"),
      ),
      body: Container(
        height: 70,
        color: Colors.grey.withOpacity(0.2),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 7,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                print("tap card $index");
                setState(() {
                  _selectedCard = index;
                });
              },
              child: Card(
                child: SizedBox(
                  width: 100,
                  child: Center(
                    child: Text("Date $index"),
                  ),
                ),
                color: index == _selectedCard ? Colors.grey : Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}
