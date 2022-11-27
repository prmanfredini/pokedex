import 'dart:convert';

import 'package:pokedex/entities/poke_stats.dart';

class Pokemon {
  final int id;
  final String name;
  final String image;
  final String type1;
  final String? type2;
  final int height;
  final int weight;
  final int exp;
  final List<PokeStats> stats;
  final String speciesUrl;

  Pokemon({
    required this.id,
    required this.name,
    required this.image,
    required this.type1,
    required this.type2,
    required this.height,
    required this.weight,
    required this.exp,
    required this.stats,
    required this.speciesUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    List<dynamic> stats = json['stats'];
    List<dynamic> types = json['types'];

    String type2 = '';
    if (types.length > 1) type2 = types[1]['type']['name'];

    return Pokemon(
      id: json['id'],
      name: json['name'],
      image: json['sprites']['other']['official-artwork']['front_default'],
      type1: json['types'][0]['type']['name'],
      type2: type2,
      height: json['height'],
      weight: json['weight'],
      exp: json['base_experience'] ?? 0,
      stats: stats.map((dynamic e) => PokeStats.fromJson(e)).toList(),
      speciesUrl: json['species']['url'],
    );
  }

  // local storage

  factory Pokemon.fromMap(Map<String, dynamic> json) => Pokemon(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        type1: json['typo1'],
        type2: json['typo2'],
        height: json['height'],
        weight: json['weight'],
        exp: json['exp'],
        stats: PokeStats.decode(json['stats']),
        speciesUrl: json['speciesUrl'],
      );

  static Map<String, dynamic> toMap(Pokemon pokemon) => {
        'id': pokemon.id,
        'name': pokemon.name,
        'image': pokemon.image,
        'typo1': pokemon.type1,
        'typo2': pokemon.type2,
        'height': pokemon.height,
        'weight': pokemon.weight,
        'exp': pokemon.exp,
        'stats': PokeStats.encode(pokemon.stats),
        'speciesUrl': pokemon.speciesUrl,
      };

  static String encode(List<Pokemon> pokemons) => json.encode(
        pokemons
            .map<Map<String, dynamic>>((pokemon) => Pokemon.toMap(pokemon))
            .toList(),
      );

  static List<Pokemon> decode(String pokemon) =>
      (json.decode(pokemon) as List<dynamic>)
          .map<Pokemon>((item) => Pokemon.fromMap(item))
          .toList();
}
