import 'package:pokedex/models/poke_stats.dart';

class Species {
  final String evolutionUrl;
  final String geracao;
  final String geracaoUrl;
  final String pokeUrl;


  Species({
    required this.evolutionUrl,
    required this.geracao,
    required this.geracaoUrl,
    required this.pokeUrl,
  });


  factory Species.fromJson(Map<String, dynamic> json) {
    return Species(
      evolutionUrl: json['evolution_chain']['url'],
      geracao: json['generation']['name'],
      geracaoUrl: json['generation']['url'],
      pokeUrl: json['varieties'][0]['pokemon']['url'],
    );
  }
}
