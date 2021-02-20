import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider/weatherapp.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counterblocapp.dart';
import 'counterproviderapp.dart';
import 'listtaskproviderapp.dart';
import 'listtaskblocapp.dart';
import 'weatherapp.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  runApp(WeatherApp());

  // runApp(MultiProvider(
  //   providers: [
  //     ChangeNotifierProvider(create: (_) => Counter()),
  //   ],
  //   child: const MyApp(),
  // ));
}

// CounterApp with Provider
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class Counter with ChangeNotifier, DiagnosticableTreeMixin {
  int _count = 0;
  int get count => _count;
  void increment() {
    print("tap increment");
    _count++;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', count));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Title"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("You have pushed the button this many time: "),
            Count(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key("increment_floatingActionButton"),
        onPressed: () => context.read<Counter>().increment(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class Count extends StatelessWidget {
  const Count({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(
      "Counter ${context.watch<Counter>().count}",
      key: const Key("counterState"),
      style: Theme.of(context).textTheme.headline4,
    );
  }
}

// ListTask with provider
class ListTaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => TodoModel(),
        child: ListTaskView(),
      ),
    );
  }
}

class ListTaskView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("List Task"),
      ),
      body: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text("Time"),
              SizedBox(
                height: 20,
              ),
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(60)),
                  color: Colors.white),
              child: Consumer<TodoModel>(
                builder: (context, todo, child) {
                  return ListView.builder(
                    itemCount: todo.taskList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          contentPadding: EdgeInsets.only(
                              left: 32, right: 32, top: 8, bottom: 8),
                          title: Text(todo.taskList[index].title),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print("tap me");
          Provider.of<TodoModel>(context, listen: false).addTaskList();
        },
      ),
    );
  }
}

class TodoModel extends ChangeNotifier {
  List<TaskModel> taskList = [];
  addTaskList() {
    TaskModel taskModel = TaskModel(
      title: "title",
      detail: "detail",
    );
    taskList.add(taskModel);
    notifyListeners();
  }
}

class TaskModel {
  String title;
  String detail;
  String get getTitle => title;
  String get getDetail => detail;
  TaskModel({this.title, this.detail});
}

// ListTaskApp with Bloc
class ListTaskBlocApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: BlocProvider(
          create: (context) => TodosBloc()..add(LoadTodoEvent()),
          child: ListTaskBlock()),
    );
  }
}

class ListTaskBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bloc"),
        ),
        body: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text("Time"),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            Expanded(
              child: Container(
                  // decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.only(
                  //         topRight: Radius.circular(50),
                  //         topLeft: Radius.circular(60)),
                  //     color: Colors.white),
                  child: BlocBuilder<TodosBloc, TodoState>(
                      builder: (context, state) {
                if (state is LoadingTodoState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is AddTodoState) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            topLeft: Radius.circular(5)),
                        color: Colors.grey),
                    child: ListView.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(state.tasks[index].title),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is LoadTodoState) {
                  return ListView.builder(
                    itemCount: state.tasks.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(state.tasks[index].title),
                        ),
                      );
                    },
                  );
                } else {
                  return Card(
                    child: ListTile(
                      title: Text(""),
                    ),
                  );
                }
              })),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            print("tap me");
            BlocProvider.of<TodosBloc>(context).add(AddTodoEvent(
                task: TaskModel(title: "title", detail: "detail")));
          },
        ));
  }
}

// Data Model
class DataService {
  List<TaskModel> tasks;
  DataService({this.tasks});
}

// Event and State
abstract class TodoEvent {}

abstract class TodoState {}

class LoadingTodoEvent extends TodoEvent {}

class LoadingTodoState extends TodoState {}

class AddTodoEvent extends TodoEvent {
  final TaskModel task;
  AddTodoEvent({this.task});
}

class AddTodoState extends TodoState {
  List<TaskModel> tasks;
  AddTodoState({this.tasks});
}

class LoadTodoEvent extends TodoEvent {}

class LoadTodoState extends TodoState {
  List<TaskModel> tasks = [];
  LoadTodoState({this.tasks});
}

// MapEventToState
class TodosBloc extends Bloc<TodoEvent, TodoState> {
  final _dataService = DataService(tasks: []);
  TodosBloc() : super(LoadTodoState(tasks: []));

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    final tasks = _dataService.tasks;
    if (event is LoadTodoEvent) {
      print("load tasks ${tasks.length}");
      yield LoadTodoState(tasks: tasks);
    }
    if (event is AddTodoEvent) {
      tasks.add(event.task);
      print("add event ${tasks.length}");
      yield AddTodoState(tasks: tasks);
    } else {
      print("load tasks ${tasks.length}");
      yield LoadTodoState(tasks: tasks);
    }
  }
}

/// Use Bloc in Builder
