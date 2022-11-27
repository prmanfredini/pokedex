import 'dart:convert';

class PokeStats {
  final int base;
  final String name;

  PokeStats({required this.base, required this.name});

  factory PokeStats.fromJson(Map<String, dynamic> json) =>
      PokeStats(base: json['base_stat'], name: json['stat']['name']);

  //local storage

  factory PokeStats.fromMap(Map<String, dynamic> json) => PokeStats(
        base: json['base'],
        name: json['name'],
      );

  static Map<String, dynamic> toMap(PokeStats pokemon) =>
      {'name': pokemon.name, 'base': pokemon.base};

  static String encode(List<PokeStats> pokemons) => json.encode(
        pokemons
            .map<Map<String, dynamic>>((pokemon) => PokeStats.toMap(pokemon))
            .toList(),
      );

  static List<PokeStats> decode(String pokemon) =>
      (json.decode(pokemon) as List<dynamic>)
          .map<PokeStats>((item) => PokeStats.fromMap(item))
          .toList();
}
