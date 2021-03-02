import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalTodoApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LocalTodoState();
}

class _LocalTodoState extends State<LocalTodoApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: ListTodoView(),
    );
  }
}

class ListTodoView extends StatelessWidget {
  const ListTodoView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
      ),
      body: BlocBuilder<TodoCubit, TodoState>(builder: (context, state) {
        if (state is ListTodoSuccess) {
          return ListView.builder(
            itemCount: state.todos.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(state.todos[index].title),
                ),
              );
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      }),
      floatingActionButton: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          return FloatingActionButton(
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
                              BlocProvider.of<TodoCubit>(context)
                                  .createTodo("OK");
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    );
                  });
            },
            child: Icon(Icons.add),
          );
        },
      ),
    );
  }
}

// TOO Data Model
class Todo {
  final String title;
  final bool isComplete;
  Todo({this.title, this.isComplete});
}

// Todo Repository
class TodoRepository {
  final List<Todo> todos;
  TodoRepository({this.todos});
}

// TODO Cubit
abstract class TodoState {}

class LoadingTodos extends TodoState {}

class ListTodoSuccess extends TodoState {
  final List<Todo> todos;
  ListTodoSuccess({this.todos});
}

class ListTodoFailure extends TodoState {
  final Exception exception;
  ListTodoFailure({this.exception});
}

class TodoCubit extends Cubit<TodoState> {
  final _todoRepo = TodoRepository(todos: []);
  TodoCubit() : super(LoadingTodos());

  void getTodos() async {
    _todoRepo.todos.add(Todo(title: "First Task"));
    print("get todos");
    emit(ListTodoSuccess(todos: _todoRepo.todos));
  }

  void createTodo(String title) async {
    _todoRepo.todos.add(Todo(title: title));
    emit(ListTodoSuccess(todos: _todoRepo.todos));
  }

  void updateTodoIsComplete(Todo todo, bool isComplete) {}
}
