import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocToBlocCommApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AddBloc(),
          ),
          BlocProvider(
              create: (context) =>
                  CounterObserverCubit(addBloc: context.read<AddBloc>()))
        ],
        child: BlocToBlocView(),
      ),
    );
  }
}

class BlocToBlocView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddBloc, int>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Bloc to Bloc"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "count: $state",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            CounterObserverView()
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            BlocProvider.of<AddBloc>(context).add(AddEvent());
          },
          child: Icon(Icons.add),
        ),
      );
    });
  }
}

class CounterObserverView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterObserverCubit, int>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "observer: $state",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
        );
      },
    );
  }
}

class AddEvent {}

class AddBloc extends Bloc<AddEvent, int> {
  AddBloc() : super(0);

  @override
  Stream<int> mapEventToState(AddEvent event) async* {
    if (event is AddEvent) {
      yield state + 1;
    }
  }
}

class CounterObserverCubit extends Cubit<int> {
  final AddBloc addBloc;
  StreamSubscription counterSubsciption;

  CounterObserverCubit({@required this.addBloc}) : super(0) {
    counterSubsciption = addBloc.listen((counter) {
      emitCounterChanged(counter);
    });
  }

  void emitCounterChanged(int counterValue) {
    print("counter changed");
    emit(counterValue * 2);
  }

  @override
  Future<void> close() {
    counterSubsciption.cancel();
    return super.close();
  }
}
