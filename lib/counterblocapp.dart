import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBlocApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: BlocProvider(
        create: (context) => CounterBloc(),
        child: CounterHomePage(),
      ),
    );
  }
}

// Use Bloc via BlockBuilder<Type>(builder: () {})
class CounterHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<CounterBloc, int>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Bloc"),
        ),
        body: Center(
          child: Text(
            "Counter $state",
            style: TextStyle(fontSize: 40),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () =>
              BlocProvider.of<CounterBloc>(context).add(Increment()),
        ),
      );
    });
  }
}

// Counter and Event
class CounterEvent {}

class Increment extends CounterEvent {}

class CounterState {}

// Map Event to State
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0);
  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    if (event is Increment) {
      yield (state + 1);
    }
  }
}
