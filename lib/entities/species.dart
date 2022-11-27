class Species {
  final String evolutionUrl;
  final String generation;
  final String genUrl;
  final String pokeUrl;

  Species({
    required this.evolutionUrl,
    required this.generation,
    required this.genUrl,
    required this.pokeUrl,
  });

  factory Species.fromJson(Map<String, dynamic> json) => Species(
        evolutionUrl: json['evolution_chain']['url'],
        generation: json['generation']['name'],
        genUrl: json['generation']['url'],
        pokeUrl: json['varieties'][0]['pokemon']['url'],
      );
}
