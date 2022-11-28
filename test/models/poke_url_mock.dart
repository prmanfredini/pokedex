import 'package:pokedex/entities/poke_url.dart';

final PokeUrl mockPokemonUrl = PokeUrl.fromJson(mockUrlJson);

final Map<String, dynamic> mockUrlJson = {
  "count": 1154,
  "next": "https://pokeapi.co/api/v2/pokemon?offset=1&limit=1",
  "previous": null,
  "results": [
    {
      "name": "bulbasaur",
      "url": "https://pokeapi.co/api/v2/pokemon/1/",
    }
  ]
};

final PokeUrl mockEmpty = PokeUrl.fromJson(mockEmptyJson);

final Map<String, dynamic> mockEmptyJson = {
  "count": 1154,
  "next": null,
  "previous": "https://pokeapi.co/api/v2/pokemon?offset=9998&limit=1",
  "results": []
};
