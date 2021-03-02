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
        home: MultiBlocProvider(
      providers: [BlocProvider(create: (context) => TodoCubit()..getTodos())],
      child: ListTodoView(),
    ));
  }
}

//
class ListTodoView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListTodoViewState();
}

class _ListTodoViewState extends State<ListTodoView> {
  final _titleController = TextEditingController();
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
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget _newTodoView() {
    return Column(
      children: [
        TextField(
          controller: _titleController,
          decoration: InputDecoration(hintText: 'Enter todo title'),
        ),
        ElevatedButton(
            onPressed: () {
              BlocProvider.of<TodoCubit>(context)
                  .createTodo(_titleController.text);
              _titleController.text = '';
              Navigator.of(context).pop();
            },
            child: Text('Save Word'))
      ],
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (context) => _newTodoView());
        });
  }
}

// _MyState and BlocProvider
class _TodosAppState extends State<LocalTodoApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: BlocProvider(
        create: (context) => TodoCubit()..getTodos(),
        child: TodosView(),
      ),
    );
  }
}

// TodoView
class TodosView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TodosViewState();
}

// _TodoViewState
class _TodosViewState extends State<TodosView> {
  final _titleController = TextEditingController();
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
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget _newTodoView() {
    return Column(
      children: [
        TextField(
          controller: _titleController,
          decoration: InputDecoration(hintText: 'Enter todo title'),
        ),
        ElevatedButton(
            onPressed: () {
              BlocProvider.of<TodoCubit>(context)
                  .createTodo(_titleController.text);
              _titleController.text = '';
              Navigator.of(context).pop();
            },
            child: Text('Save Todo'))
      ],
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (context) => _newTodoView());
        });
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
