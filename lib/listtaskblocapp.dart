import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListTaskBlocAppTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: BlocProvider(
        create: (context) => TaskBloc()..add(LoadTaskEvent()),
        child: ListTaskBlocAppHomePage(),
      ),
    );
  }
}

class ListTaskBlocAppHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc List Task"),
      ),
      body: Center(
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is LoadTaskState) {
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
            } else if (state is AddTaskState) {
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
              return Text(
                "Tasks Bloc $state",
                style: TextStyle(fontSize: 40),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {
          print("add task"),
          BlocProvider.of<TaskBloc>(context).add(AddTaskEvent(
              task: BlocTaskModel(title: "newtask", detail: "detail")))
        },
      ),
    );
  }
}

// TaskModel
class BlocTaskModel {
  String title;
  String detail;
  BlocTaskModel({this.title, this.detail});
}

// Event and State
abstract class TaskEvent {}

abstract class TaskState {}

class AddTaskEvent extends TaskEvent {
  final BlocTaskModel task;
  AddTaskEvent({this.task});
}

class AddTaskState extends TaskState {
  List<BlocTaskModel> tasks;
  AddTaskState({this.tasks});
}

class LoadingTaskEvent extends TaskEvent {}

class LoadingTaskState extends TaskState {}

class LoadTaskEvent extends TaskEvent {}

class LoadTaskState extends TaskState {
  List<BlocTaskModel> tasks;
  LoadTaskState({this.tasks});
}

// MapEventToState
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  List<BlocTaskModel> _tasks = [];
  TaskBloc() : super(LoadTaskState(tasks: []));
  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is LoadTaskEvent) {
      yield LoadTaskState(tasks: []);
    } else if (event is AddTaskEvent) {
      _tasks.add(event.task);
      yield AddTaskState(tasks: _tasks);
    } else {
      yield LoadingTaskState();
    }
  }
}

// Use BlocProvider<type>(builder: (){})
