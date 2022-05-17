import 'package:pokedex/models/poke_stats.dart';

class Pokemon {
  final int id;
  final String nome;
  final String imagem;
  final String tipo1;
  final String? tipo2;
  final int height;
  final int weight;
  final int exp;
  final List<PokeStats> stats;
  final String speciesUrl;

  Pokemon({
    required this.id,
    required this.nome,
    required this.imagem,
    required this.tipo1,
    required this.tipo2,
    required this.height,
    required this.weight,
    required this.exp,
    required this.stats,
    required this.speciesUrl,
  });


  factory Pokemon.fromJson(Map<String, dynamic> json) {
    String tipoOpcional = '';
    List<dynamic> stats = json['stats'];

    List<dynamic> types = json['types'];
    if (types.length > 1) {
      tipoOpcional = types[1]['type']['name'];
    }
    return Pokemon(
      id: json['id'],
      nome: json['name'],
      //imagem: json['sprites']['other']['official-artwork']['front_default'], // default pic
      imagem: json['sprites']['other']['dream_world']['front_default'],  // dream pic
      tipo1: json['types'][0]['type']['name'],
      tipo2: tipoOpcional,
      height: json['height'],
      weight: json['weight'],
      exp: json['base_experience'],
      stats: stats.map((dynamic jsons) => PokeStats.fromJson(jsons)).toList(),
      speciesUrl: json['species']['url'],
    );
  }
}
