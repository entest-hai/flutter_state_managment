import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import 'package:flutter_provider/blocnavigation.dart';

class CTGApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CTGAppState();
  }
}

class _CTGAppState extends State<CTGApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [BlocProvider(create: (context) => CTGCubit())],
        child: CTGNav(),
      ),
    );
  }
}

class CTGNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Navigator(
      pages: [
        MaterialPage(child: DataListView()),
      ],
      onPopPage: (route, result) {
        return route.didPop(result);
      },
    );
  }
}

class DataListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DataListViewState();
  }
}

class _DataListViewState extends State<DataListView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Data"),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              onTap: () {
                BlocProvider.of<CTGCubit>(context).getCTG("$index");
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return CTGDetailView();
                    }).whenComplete(() {
                  BlocProvider.of<CTGCubit>(context).popToDataList();
                });
              },
              child: ListTile(
                title: Text("Data"),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet<void>(
              context: context,
              builder: (context) {
                return _detailView();
              }).whenComplete(() {
            print("OK");
          });
        },
      ),
    );
  }

  Widget _detailView() {
    return Container(
      child: Center(
        child: Text("Detail View"),
      ),
    );
  }
}

// CTGDetailView
class CTGDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<CTGCubit, CTGAPIState>(builder: (context, state) {
      if (state is LoadingCTG) {
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is LoadedCTGSuccess) {
        return Container(
          child: Center(
            child: Text("CTG View: ${state.result}"),
          ),
        );
      } else {
        return Container(
          child: Center(
            child: Text("Exception"),
          ),
        );
      }
    });
  }
}

// CTG Repository
class CTGRepository {
  Future<String> getCTG(String url) async {
    await Future.delayed(const Duration(seconds: 2));
    return url;
  }
}

// CTGCubit
abstract class CTGAPIState {}

class LoadingCTG extends CTGAPIState {}

class LoadedCTGSuccess extends CTGAPIState {
  String result;
  LoadedCTGSuccess({this.result});
}

class CTGCubit extends Cubit<CTGAPIState> {
  final _ctgRepository = CTGRepository();
  CTGCubit() : super(LoadingCTG());

  void getCTG(String url) async {
    final result = await _ctgRepository.getCTG(url);
    emit(LoadedCTGSuccess(result: result));
  }

  void popToDataList() {
    emit(LoadingCTG());
  }
}
