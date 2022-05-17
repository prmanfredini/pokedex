

import 'package:dio/dio.dart';
import 'package:pokedex/models/species.dart';

import '../models/poke_response.dart';
import '../models/poke_url.dart';
import '../models/pokemon.dart';

class PokeDio{
String baseURL = "https://pokeapi.co/api/v2";


  Future<List<Pokemon>> getPokemonList(int index) async {
    Response response = await Dio().get('$baseURL/pokemon?offset=$index&limit=30');
    final List<dynamic> decodedJson = response.data['results'];
    List<PokeUrl> lista = decodedJson.map((dynamic json) => PokeUrl.fromJson(json)).toList();

    final List<Pokemon> pokemonList = [];

    for (var e in lista) {
      Response resp = await Dio().get(e.url);
      final x = resp.data;
      pokemonList.add(Pokemon.fromJson(x));
    }

    if (response.statusCode == 200 && pokemonList.isNotEmpty) {
      return pokemonList;
    } else {
      throw "Server Error";
    }
  }

  Future<List<Pokemon>> getPokemonDetails(int index) async {
      Response response = await Dio().get('$baseURL/pokemon-species/$index');
      final List<dynamic> decodedJson = response.data['results'];
      List<PokeUrl> lista = decodedJson.map((dynamic json) => PokeUrl.fromJson(json)).toList();

      final List<Pokemon> pokemonList = [];

      for (var e in lista) {
        Response resp = await Dio().get(e.url);
        final x = resp.data;
        pokemonList.add(Pokemon.fromJson(x));
      }

      if (response.statusCode == 200 && pokemonList.isNotEmpty) {
        return pokemonList;
      } else {
        throw "Server Error";
      }
  }

  Future<List<Pokemon>> getPokemonListByGeneration(int index) async {
      Response response = await Dio().get('$baseURL/generation/$index');
      final List<dynamic> decodedJson = response.data['pokemon_species'];
      List<PokeResponse> lista = decodedJson.map((dynamic json) => PokeResponse.fromJson(json)).toList();

      final List<Species> specieList = [];
      final List<Pokemon> pokemonList = [];


      for (var e in lista){
        if (e.url != null) {
          Response resp = await Dio().get(e.url!);
          final x = resp.data;
          specieList.add(Species.fromJson(x));
        }
      }
      for (var e in specieList){
          Response resp = await Dio().get(e.pokeUrl);
          final x = resp.data;
          pokemonList.add(Pokemon.fromJson(x));
      }



      if (response.statusCode == 200 && pokemonList.isNotEmpty) {
        return pokemonList;
      } else {
        throw "Server Error";
      }
  }

  Future<List<Pokemon>> getReverse(int index) async {
    Response response = await Dio().get('$baseURL/pokemon?offset=$index&limit=30');
    final List<dynamic> decodedJson = response.data['results'];
    List<PokeUrl> lista = decodedJson.map((dynamic json) => PokeUrl.fromJson(json)).toList();

    final List<Pokemon> pokemonList = [];

    for (var e in lista) {
      Response resp = await Dio().get(e.url);
      final x = resp.data;
      pokemonList.add(Pokemon.fromJson(x));
    }

    if (response.statusCode == 200 && pokemonList.isNotEmpty) {
      return pokemonList;
    } else {
      throw "Server Error";
    }
  }



}