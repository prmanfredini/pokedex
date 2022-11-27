import 'package:pokedex/entities/pokemon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDex {
  // final String key = 'pokemons';
  // final String fav = 'favorites';
  List<Pokemon> myList = [];
  SharedPreferences? _pref;

  LocalDex() {
    _initPrefs();
  }

  _initPrefs() async {
    _pref ??= await SharedPreferences.getInstance();
  }

  Future<List<Pokemon>> _loadFromPrefs(String key) async {
    await _initPrefs();
    final map = _pref?.getString(key) ?? '';
    if (map.isEmpty) {
      return [];
    }
    myList = List.of(Pokemon.decode(map));
    return myList;
  }

  _saveToPrefs(List<Pokemon> pokemons, String key) async {
    await _initPrefs();
    _pref?.setString(key, Pokemon.encode(pokemons));
  }

  Future<List<Pokemon>> getPokemons(String key) async {
    List<Pokemon> pokemons = await _loadFromPrefs(key);
    pokemons.sort((a, b) => a.id.compareTo(b.id));
    return pokemons;
  }

  Future addList(List<Pokemon> poke) async {
    for (var element in poke) {
      await addPokemon(element, 'pokemons');
    }
  }

  Future addPokemon(Pokemon poke, String key) async {
    List<Pokemon> pokemons = await _loadFromPrefs(key);
    if (pokemons.any((e) => e.id == poke.id)) return null;
    pokemons.add(poke);
    pokemons.sort((a, b) => a.id.compareTo(b.id));
    await _saveToPrefs(pokemons, key);
  }

  Future removePokemon(Pokemon poke, String key) async {
    List<Pokemon> pokemons = await _loadFromPrefs(key);
    if (pokemons.isNotEmpty || pokemons.any((e) => e.id != poke.id)) {
      pokemons.removeWhere((e) => e.id == poke.id);
      pokemons.sort((a, b) => a.id.compareTo(b.id));
      await _saveToPrefs(pokemons, key);
    }
  }

}
