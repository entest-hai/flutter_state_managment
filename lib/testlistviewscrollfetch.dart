import 'package:flutter/material.dart';
import 'dart:async';

class ListViewScrollFetchApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListViewScrollState();
  }
}

class _ListViewScrollState extends State<ListViewScrollFetchApp> {
  var _hasReachMax = true;
  var _numItem = 20;
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _onScroll();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final minScroll = _scrollController.position.minScrollExtent;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (minScroll - currentScroll > _scrollThreshold) {
      fetchData();
    }
  }

  Future<void> fetchData() async {
    print("fetch more message now");
    setState(() {
      _hasReachMax = false;
    });
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _numItem = _numItem + 1;
        _hasReachMax = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Scoll"),
        ),
        body: Column(
          children: [
            _hasReachMax ? SizedBox() : BottomLoader(),
            Expanded(
                child: ListView.builder(
              controller: _scrollController,
              itemCount: _numItem,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text("Card $index"),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}
