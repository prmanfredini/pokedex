import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:pokedex/bloc/poke_controller.dart';
import 'package:pokedex/database/local_storage.dart';
import 'package:pokedex/entities/pokemon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'controller_test.mocks.dart';
import 'models/pokemon_data_mock.dart';

final pokemon = mockPokemonModel;
final pokemon2 = buildPoke(pokemon);
final list = [pokemon, pokemon2];

// class MockLocalDex extends Mock implements LocalDex {
//   @override
//   Future<List<Pokemon>> getPokemons(String key) =>
//       super.noSuchMethod(Invocation.method(#getPokemons, list));
// }
//
// class MockPokeController extends Mock implements PokeController {
//   @override
//   get localDex => MockLocalDex();
//   @override
//   Future<List<Pokemon>> search(String valor) =>
//       super.noSuchMethod(Invocation.method(#search, list));
//
// }

@GenerateNiceMocks([
  MockSpec<PokeController>(as: #MockPokeController),
  MockSpec<LocalDex>(as: #MockLocalDex)
])

void main() {
  final localMock = MockLocalDex();
  final pcMock = MockPokeController();

  void getLocal() {
    when(localMock.getPokemons('key'))
        .thenAnswer((_) async => [pokemon, pokemon2]);
  }

  group('GetPokemons', () {

    test('Should get pokemons with the letter i', () async {
      getLocal();

      final pokemonGroup = await pcMock.search('i');

      expect(pokemonGroup, isA<List<Pokemon>>());
      expect(pokemonGroup.length, 1);
    });

    test('Should not get any pokemon', () async {
      getLocal();

      final pokemonGroup = await pcMock.search('x');

      expect(pokemonGroup, isA<List<Pokemon>>());
      expect(pokemonGroup.length, 0);
    });

    test('Should get favorite ones', () async {
      getLocal();

      final pokemonGroup = await pcMock.favorites(true);

      expect(pokemonGroup, isA<List<Pokemon>>());
      expect(pokemonGroup.length, 2);
    });

    test('Should sorted by lowest id', () async {
      getLocal();

      final pokemonGroup = await pcMock.sort('Smallest number first');

      expect(pokemonGroup.length, 2);
      expect(pokemonGroup.first.id, 1);
    });

    test('Should sorted by highest id', () async {
      getLocal();

      final pokemonGroup = await pcMock.sort('Highest number first');

      expect(pokemonGroup.length, 2);
      expect(pokemonGroup.first.id, 2);
    });

    test('Should sorted by alphabet order', () async {
      getLocal();

      final pokemonGroup = await pcMock.sort('A-Z');

      expect(pokemonGroup.length, 2);
      expect(pokemonGroup.first.name.compareTo(pokemonGroup.last.name), true);
    });

    test('Should sorted by reverse alphabet order', () async {
      getLocal();

      final pokemonGroup = await pcMock.sort('Z-A');

      expect(pokemonGroup.length, 2);
      expect(pokemonGroup.first.name.compareTo(pokemonGroup.last.name), false);
    });

    test('Should filter by grass type', () async {
      getLocal();

      final pokemonGroup = await pcMock.setFilter(
          types: ['grass'],
          heights: [],
          weights: [],
          range: RangeValues(0, 905));

      expect(pokemonGroup.length, 1);
      expect(pokemonGroup.first.type1, 'grass');
    });

    test('Should not get pokemons', () async {
      getLocal();

      final pokemonGroup = await pcMock.search('b');

      expect(pokemonGroup, []);
    });
  });
}
