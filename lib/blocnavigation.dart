import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocNavApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: MultiBlocProvider(
          providers: [BlocProvider(create: (context) => NavCubit())],
          child: NavView()),
    );
  }
}

class NavView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<NavCubit, Post>(
      builder: (context, post) {
        return Navigator(
          pages: [
            MaterialPage(child: BlockNavHomePageCubit()),
            if (post != null)
              MaterialPage(
                  child: DetailView(
                post: post,
              ))
          ],
          onPopPage: (route, result) {
            BlocProvider.of<NavCubit>(context).popToPosts();
            return route.didPop(result);
          },
        );
      },
    );
  }
}

class BlockNavHomePage extends StatelessWidget {
  final posts = List<String>.generate(100, (index) => "messaage $index");
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("BlocNav"),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailView(
                            post: Post(message: "message $index"),
                          )))
            },
            child: Card(
              child: ListTile(
                title: Text(posts[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}

class BlockNavHomePageCubit extends StatelessWidget {
  final posts = List<String>.generate(100, (index) => "messaage $index");
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("BlocNav"),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => {print('tap me $index')},
            child: Card(
              child: ListTile(
                title: Text(posts[index]),
                onTap: () => BlocProvider.of<NavCubit>(context)
                    .showPostDetails(Post(message: posts[index])),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailView extends StatelessWidget {
  final Post post;
  DetailView({this.post});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: Center(
        child: Text(post.message),
      ),
    );
  }
}

// Data Model
class Post {
  final String message;
  Post({this.message});
}

// Cubit
class NavCubit extends Cubit<Post> {
  NavCubit() : super(null);

  void showPostDetails(Post post) {
    // DetailCubit Call API Given Post or ID
    // DetailView Access to This DetailCubit
    emit(post);
  }

  void popToPosts() => emit(null);
}
