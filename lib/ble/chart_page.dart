import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChatPageState();
  }
}

class _ChatPageState extends State<ChatPage> {
  List<Message> messages = [];
  final TextEditingController textEditingController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Chat BLE"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                  child: ListView(
                padding: EdgeInsets.all(12.0),
                children: buildMessages(messages),
              )),
              Row(
                children: [
                  Flexible(
                      child: Container(
                          margin: EdgeInsets.only(left: 16.0),
                          child: TextField(
                            controller: textEditingController,
                            style: TextStyle(fontSize: 15.0),
                            decoration: InputDecoration.collapsed(
                              hintText: "Type your message ...",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ))),
                  Container(
                    margin: EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        _sendMessage(textEditingController.text);
                        textEditingController.clear();
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _sendMessage(String message) {
    setState(() {
      messages.add(Message(message: message, id: messages.length + 1));
    });
  }

  List<Widget> buildMessages(List<Message> messages) {
    List<Widget> list = messages
        .map((message) => Row(
              mainAxisAlignment: message.id % 2 == 0
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    message.message,
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                  width: 222.0,
                  decoration: BoxDecoration(
                      color: message.id % 2 == 0 ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(7.0)),
                )
              ],
            ))
        .toList();
    return list;
  }
}

class Message {
  final String message;
  final int id;
  Message({this.message, this.id});
}
