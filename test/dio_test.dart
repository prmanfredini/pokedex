import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pokedex/entities/poke_url.dart';
import 'package:pokedex/entities/pokemon.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/services/dio_pokemon.dart';
import 'dio_test.mocks.dart';
import 'models/poke_url_mock.dart';
import 'models/pokemon_data_mock.dart';
import 'package:mockito/annotations.dart';

final url = 'https://exemple.com';
final pokeUrl = mockPokemonUrl;
final list = [mockPokemonModel, buildPoke(mockPokemonModel)];

@GenerateNiceMocks(
    [MockSpec<Dio>(as: #MockDio), MockSpec<PokeDio>(as: #MockPokeDio)])
void main() async {
  final dioMock = MockDio();
  final pokeDio = MockPokeDio();
  final RequestOptions options = RequestOptions(path: '');

  Future getEmptyResponse() async {
    when(dioMock.get(url)).thenAnswer((_) async => Response(
        statusCode: 200, data: mockEmptyJson, requestOptions: options));
  }

  Future getUrlResponse() async {
    when(dioMock.get(url)).thenAnswer((_) async =>
        Response(statusCode: 200, data: mockUrlJson, requestOptions: options));
  }

  Future getPokeResponse() async {
    when(dioMock.get(url)).thenAnswer((_) async => Response(
        statusCode: 200,
        data: jsonEncode(mockPokemonJson),
        requestOptions: options));
  }

  group('getPokemons', () {
    test('Should return a PokemonGroup', () async {
      await getUrlResponse();
      await getPokeResponse();

      final pokemonGroup = await pokeDio.getPokemonList(0);

      when(Pokemon.fromJson(mockPokemonJson)).thenReturn(mockPokemonModel);
      when(PokeUrl.fromJson(mockUrlJson)).thenReturn(pokeUrl);

      expect(pokemonGroup, isA<List<Pokemon>>());
      expect(pokemonGroup.length, 1);
    });

    test('Should not get pokemons', () async {
      getEmptyResponse();

      expect(() => pokeDio.getPokemonList(-1), []);
    });

    test('Should return all generation', () async {
      await getUrlResponse();
      await getPokeResponse();

      final pokemonGroup = await pokeDio.getPokemonListByGeneration(1);

      when(Pokemon.fromJson(mockPokemonJson)).thenReturn(mockPokemonModel);
      when(PokeUrl.fromJson(mockUrlJson)).thenReturn(pokeUrl);

      expect(pokemonGroup, isA<List<Pokemon>>());
      expect(pokemonGroup.length, 1);
    });

    test('Should not get pokemons by generation', () async {
      getEmptyResponse();

      expect(() => pokeDio.getPokemonListByGeneration(0), []);
    });

    test('Should return one pokemon', () async {
      await getUrlResponse();
      await getPokeResponse();

      final pokemonGroup = await pokeDio.getPokemonList(0);

      when(Pokemon.fromJson(mockPokemonJson)).thenReturn(mockPokemonModel);
      when(PokeUrl.fromJson(mockUrlJson)).thenReturn(pokeUrl);

      expect(pokemonGroup, isA<List<Pokemon>>());
      expect(pokemonGroup.length, 1);
    });

    test('Should not get pokemons', () async {
      getEmptyResponse();

      expect(() => pokeDio.getPokemonList(-1), []);
    });

    test('Should not get Server error', () async {
      getEmptyResponse();

      expect(() => pokeDio.getPokemonListByGeneration(0), 'Server Error');
    });
  });
}
