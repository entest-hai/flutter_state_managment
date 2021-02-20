import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListTaskProviderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => TaskProvider(),
        child: ListTaskProviderAppHomePage(),
      ),
    );
  }
}

class ListTaskProviderAppHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("TaskProvider"),
      ),
      body: Center(
        child: Consumer<TaskProvider>(
          builder: (context, state, child) {
            return ListView.builder(
              itemCount: state._tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text("${state._tasks[index].title}"),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {
          print("add task"),
          Provider.of<TaskProvider>(context, listen: false)
              .addTask(MyTaskModel(title: "newtask", detail: "detail"))
        },
      ),
    );
  }
}

// TaskModel
class MyTaskModel {
  String title;
  String detail;
  MyTaskModel({this.title, this.detail});
}

// TaskProvider extends ChangeNotifier
class TaskProvider extends ChangeNotifier {
  List<MyTaskModel> _tasks = [];

  void addTask(MyTaskModel task) {
    _tasks.add(task);
    notifyListeners();
  }
}

// Use TaskProvide via ChangeNotifierProvider
