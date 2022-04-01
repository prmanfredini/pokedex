
import 'package:dio/dio.dart';
import 'package:pokedex/models/pokemon.dart';


String postsURL = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=20";
String url = postsURL;

  Future<List<PokeUrl>> getNext() async {
    //print('get more 20 pokemon');
    var response = await Dio().get(url);
    url = response.data['next'];
    var res = await Dio().get(url);
    final List<dynamic> decodedJson = res.data['results'];
    return decodedJson
        .map((dynamic json) => PokeUrl.fromJson(json))
        .toList();
  }


  Future<List<PokeUrl>> getPokeUrl() async {
      var response = await Dio().get(postsURL);
      final List<dynamic> decodedJson = response.data['results'];

    return decodedJson
        .map((dynamic json) => PokeUrl.fromJson(json))
        .toList();
  }


  Future<Pokemon> getCatch(String url) async {
    //print('get 1 pokemon');
    final response = await Dio().get(url);
    var decodedJson = response.data;
    return Pokemon.fromJson(decodedJson);
  }
