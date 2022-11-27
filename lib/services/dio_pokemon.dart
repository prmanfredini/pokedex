import 'package:dio/dio.dart';
import 'package:pokedex/database/local_storage.dart';
import 'package:pokedex/entities/species.dart';

import '../entities/poke_response.dart';
import '../entities/poke_url.dart';
import '../entities/pokemon.dart';

class PokeDio {
  final Dio dio = Dio();
  final pokeDex = LocalDex();
  String baseURL = "https://pokeapi.co/api/v2";

  Future<List<Pokemon>> getPokemonList(int index) async {
    Response response =
        await dio.get('$baseURL/pokemon?offset=$index&limit=30');

    final List<dynamic> decodedJson = response.data['results'];

    List<PokeUrl> auxList =
        decodedJson.map((dynamic json) => PokeUrl.fromJson(json)).toList();

    List<Pokemon> pokemonList = [];

    for (var e in auxList) {
      Response resp = await dio.get(e.url);
      final x = resp.data;
      final poke = Pokemon.fromJson(x);
      pokemonList.add(poke);
    }

    await pokeDex.addList(pokemonList);

    if (response.statusCode == 200 && pokemonList.isNotEmpty) {
      return pokemonList;
    } else {
      throw "Server Error";
    }
  }

  Future<List<Pokemon>> getPokemonListByGeneration(int index) async {
    Response response = await dio.get('$baseURL/generation/$index');
    final List<dynamic> decodedJson = response.data['pokemon_species'];

    List<PokeResponse> auxList =
        decodedJson.map((dynamic json) => PokeResponse.fromJson(json)).toList();

    final List<Species> specieList = [];
    final List<Pokemon> pokemonList = [];

    for (var e in auxList) {
      if (e.url != null) {
        Response resp = await dio.get(e.url!);
        final x = resp.data;
        specieList.add(Species.fromJson(x));
      }
    }
    for (var e in specieList) {
      Response resp = await dio.get(e.pokeUrl);
      final x = resp.data;
      final poke = Pokemon.fromJson(x);
      pokemonList.add(poke);
    }

    if (response.statusCode == 200 && pokemonList.isNotEmpty) {
      pokemonList.sort((a, b) => a.id.compareTo(b.id));
      return pokemonList;
    } else {
      throw "Server Error";
    }
  }

  Future<List<Pokemon>> searchPokemon(String name) async {
    Response response = await dio.get('$baseURL/pokemon/$name');
    final decodedJson = response.data;

    final List<Pokemon> pokemonList = [];

    final poke = Pokemon.fromJson(decodedJson);

    pokemonList.add(poke);

    if (response.statusCode == 200 && pokemonList.isNotEmpty) {
      return [poke];
    } else {
      throw Exception();
    }
  }
}
