import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterProviderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => CounterProvider(),
        child: CounterProviderAppHomePage(),
      ),
    );
  }
}

class CounterProviderAppHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("ProviderCounter"),
      ),
      body: Center(
        child: Text(
          "Counter ${context.watch<CounterProvider>()._counter}",
          style: TextStyle(fontSize: 40),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            {print("tap me"), context.read<CounterProvider>().increment()},
      ),
    );
  }
}

class CounterProvider extends ChangeNotifier {
  int _counter = 0;

  void increment() {
    _counter = _counter + 1;
    notifyListeners();
  }
}
