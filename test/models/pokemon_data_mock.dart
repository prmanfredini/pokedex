import 'package:pokedex/entities/pokemon.dart';

final Pokemon mockPokemonModel = Pokemon.fromJson(mockPokemonJson);

Pokemon buildPoke(Pokemon poke){
  return Pokemon(
    id: 1,
    name: 'bulbasaur',
    image: poke.image,
    type1: 'bug',
    type2: poke.type2,
    height: poke.height,
    weight: poke.weight,
    exp: poke.exp,
    stats: poke.stats,
    speciesUrl: poke.speciesUrl,
  );
}

final Map<String, dynamic> mockPokemonJson = {
  "base_experience": 142,
  "height": 10,
  "id": 2,
  "name": "ivysaur",
  "species": {
    "name": "ivysaur",
    "url": "https://pokeapi.co/api/v2/pokemon-species/2/"
  },
  "sprites": {
    "other": {
      "official-artwork": {
        "front_default":
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/2.png"
      }
    }
  },
  "stats": [
    {
      "base_stat": 60,
      "effort": 0,
      "stat": {"name": "hp", "url": "https://pokeapi.co/api/v2/stat/1/"}
    },
    {
      "base_stat": 62,
      "effort": 0,
      "stat": {"name": "attack", "url": "https://pokeapi.co/api/v2/stat/2/"}
    },
    {
      "base_stat": 63,
      "effort": 0,
      "stat": {"name": "defense", "url": "https://pokeapi.co/api/v2/stat/3/"}
    },
    {
      "base_stat": 80,
      "effort": 1,
      "stat": {
        "name": "special-attack",
        "url": "https://pokeapi.co/api/v2/stat/4/"
      }
    },
    {
      "base_stat": 80,
      "effort": 1,
      "stat": {
        "name": "special-defense",
        "url": "https://pokeapi.co/api/v2/stat/5/"
      }
    },
    {
      "base_stat": 60,
      "effort": 0,
      "stat": {"name": "speed", "url": "https://pokeapi.co/api/v2/stat/6/"}
    }
  ],
  "types": [
    {
      "slot": 1,
      "type": {"name": "grass", "url": "https://pokeapi.co/api/v2/type/12/"}
    },
    {
      "slot": 2,
      "type": {"name": "poison", "url": "https://pokeapi.co/api/v2/type/4/"}
    }
  ],
  "weight": 130
};
