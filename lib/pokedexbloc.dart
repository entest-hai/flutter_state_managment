import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class PokedexApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [BlocProvider(create: (context) => PokemonBloc()..add(PokemonPageRequest(page: 0)))],
        child: PokedexHomePage(),
      )
    );
  }
}

class PokedexHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex'),
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PokemonPageLoadSuccess) {
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: state.pokemonListings.length,
              itemBuilder: (context, index) {
                return Card(
                  child: GridTile(
                    child: Column(
                      children: [
                        Image.network(state.pokemonListings[index].imageUrl),
                        Text(state.pokemonListings[index].name)
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is PokemonPageLoadFailed) {
            return Center(
              child: Text(state.error.toString()),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

// Data Model 
class PokemonListing {
  final int id;
  final String name;

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

  PokemonListing({@required this.id, @required this.name});

  factory PokemonListing.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    final url = json['url'] as String;
    final id = int.parse(url.split('/')[6]);
    return PokemonListing(id: id, name: name);
  }
}

// Parser
class PokemonPageResponse {
  final List<PokemonListing> pokemonListings;
  final bool canLoadNextPage;

  PokemonPageResponse(
      {@required this.pokemonListings, @required this.canLoadNextPage});

  factory PokemonPageResponse.fromJson(Map<String, dynamic> json) {
    final canLoadNextPage = json['next'] != null;
    final pokemonListings = (json['results'] as List)
        .map((listingJson) => PokemonListing.fromJson(listingJson))
        .toList();

    return PokemonPageResponse(
        pokemonListings: pokemonListings, canLoadNextPage: canLoadNextPage);
  }
}

// Repository and API Request 
class PokemonRepository {
  final baseUrl = 'pokeapi.co';
  final client = http.Client();

  Future<PokemonPageResponse> getPokemonPage(int pageIndex) async {
    // pokemon?limit=200&offset=400

    final queryParameters = {
      'limit': '200',
      'offset': (pageIndex * 200).toString()
    };

    final uri = Uri.https(baseUrl, '/api/v2/pokemon', queryParameters);
    final response = await client.get(uri);
    final json = jsonDecode(response.body);

    return PokemonPageResponse.fromJson(json);
  }
}

// Event and State 
abstract class PokemonEvent {}

class PokemonPageRequest extends PokemonEvent {
  final int page; 
  PokemonPageRequest({@required this.page});
}

abstract class PokemonState {}

class PokemonInitial extends PokemonState {}

class PokemonLoadInProgress extends PokemonState {}

class PokemonPageLoadSuccess extends PokemonState {
  final List<PokemonListing> pokemonListings;
  final bool canLoadNextpage; 

  PokemonPageLoadSuccess(
    {@required this.pokemonListings, @required this.canLoadNextpage}
  );
}

class PokemonPageLoadFailed extends PokemonState {
  final Error error; 
  PokemonPageLoadFailed({@required this.error});
}

// Bloc 
class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final _pokemonRepository = PokemonRepository();
  PokemonBloc() : super(PokemonInitial());

  @override 
  Stream<PokemonState> mapEventToState(PokemonEvent event) async* {
    if (event is PokemonPageRequest) {
      yield PokemonLoadInProgress();

      try {
        final pokemonPageResponse = await _pokemonRepository.getPokemonPage(0);
        yield PokemonPageLoadSuccess(
          pokemonListings: pokemonPageResponse.pokemonListings,
          canLoadNextpage: pokemonPageResponse.canLoadNextPage);
          } catch (e) {
            yield PokemonPageLoadFailed(error: e);
          }
      }
    }
}
