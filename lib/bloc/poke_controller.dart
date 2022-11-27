import 'dart:async';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/components/filter_sizes.dart';
import 'package:pokedex/database/local_storage.dart';
import 'package:pokedex/entities/pokemon.dart';
import 'package:pokedex/services/dio_pokemon.dart';

// ignore: constant_identifier_names
enum StatePage { DONE, FILTER, EMPTY, LOADING }

class PokeController {
  final PokeDio pokeDio = PokeDio();
  final LocalDex localDex = LocalDex();

  List<Pokemon> pokeList = [];

  final _filterStateStream = StreamController<StatePage>.broadcast();

  Stream<StatePage> get streamFilterState => _filterStateStream.stream;

  final _pageStateStream =
      StreamController<PagingState<int, Pokemon>>.broadcast();

  Stream<PagingState<int, Pokemon>> get streamPagingState =>
      _pageStateStream.stream;

  void clear() {
    _filterStateStream.sink.add(StatePage.DONE);
  }

  Future<List<Pokemon>> getPokemon(int index) async {
    Iterable<Pokemon> response = [];
    try {
      response = await pokeDio.getPokemonList(index);
    } catch (e) {
      _filterStateStream.sink.add(StatePage.EMPTY);
    }
    pokeList.addAll(response);
    final isLastPage = index >= 1126;
    final nextPageKey = isLastPage ? null : index + 30;
    _pageStateStream.sink.add(
        PagingState(error: null, nextPageKey: nextPageKey, itemList: pokeList));
    _filterStateStream.sink.add(StatePage.DONE);
    return pokeList;
  }

  Future<List<Pokemon>> search(String value, {List<Pokemon> list = const []}) async {
    _filterStateStream.sink.add(StatePage.LOADING);
    list = list.isNotEmpty ? list : await localDex.getPokemons('pokemons');
    List<Pokemon> filter = list.where((e) => e.name.contains(value)).toList();
    if (value.isNotEmpty && filter.isNotEmpty) {
      _filterStateStream.sink.add(StatePage.FILTER);
    } else if (value.isNotEmpty && filter.isEmpty) {
      _filterStateStream.sink.add(StatePage.EMPTY);
    } else if (value.isEmpty && filter.isEmpty){
      _filterStateStream.sink.add(StatePage.DONE);
    }    else {
      filter = list;
      _filterStateStream.sink.add(StatePage.FILTER);
    }
    return filter;
  }

  Future<List<Pokemon>> favorites(bool value) async {
    _filterStateStream.sink.add(StatePage.LOADING);
    List<Pokemon> list = await localDex.getPokemons('favorites');
    value
        ? _filterStateStream.sink.add(StatePage.FILTER)
        : _filterStateStream.sink.add(StatePage.DONE);
    if (list.isEmpty) _filterStateStream.sink.add(StatePage.EMPTY);
    return list;
  }

  Future<List<Pokemon>> sort(String value) async {
    _filterStateStream.sink.add(StatePage.FILTER);
    final localPokeList = await localDex.getPokemons('pokemons');
    switch (value) {
      case 'Highest number first':
        return localPokeList.reversed.toList();
      case 'A-Z':
        localPokeList.sort((a, b) => a.name.compareTo(b.name));
        return localPokeList;
      case 'Z-A':
        localPokeList.sort((a, b) => b.name.compareTo(a.name));
        return localPokeList;
      default:
        _filterStateStream.sink.add(StatePage.DONE);
        return localPokeList;
    }
  }

  Future<List<Pokemon>> getGeneration(String value) async {
    _filterStateStream.sink.add(StatePage.LOADING);
    final localPokeList = await localDex.getPokemons('pokemons');
    List<Pokemon> filter = [];
    switch (value) {
      case 'Generation I':
        if (localPokeList.any((e) => e.id == 1) &&
            localPokeList.any((e) => e.id == 151) &&
            localPokeList.length >= 151) {
          filter = localPokeList.sublist(0, 151);
        } else {
          filter = await pokeDio.getPokemonListByGeneration(1);
        }
        break;
      case 'Generation II':
        if (localPokeList.any((e) => e.id == 152) &&
            localPokeList.any((e) => e.id == 251) &&
            localPokeList.length >= 251) {
          filter = localPokeList.sublist(151, 251);
        } else {
          filter = await pokeDio.getPokemonListByGeneration(2);
        }
        break;
      case 'Generation III':
        if (localPokeList.any((e) => e.id == 252) &&
            localPokeList.any((e) => e.id == 386) &&
            localPokeList.length >= 386) {
          filter = localPokeList.sublist(251, 386);
        } else {
          filter = await pokeDio.getPokemonListByGeneration(3);
        }
        break;
      case 'Generation IV':
        if (localPokeList.any((e) => e.id == 387) &&
            localPokeList.any((e) => e.id == 493) &&
            localPokeList.length >= 493) {
          filter = localPokeList.sublist(386, 493);
        } else {
          filter = await pokeDio.getPokemonListByGeneration(4);
        }
        break;
      case 'Generation V':
        if (localPokeList.any((e) => e.id == 494) &&
            localPokeList.any((e) => e.id == 649) &&
            localPokeList.length >= 649) {
          filter = localPokeList.sublist(493, 649);
        } else {
          filter = await pokeDio.getPokemonListByGeneration(5);
        }
        break;
      case 'Generation VI':
        if (localPokeList.any((e) => e.id == 650) &&
            localPokeList.any((e) => e.id == 721) &&
            localPokeList.length >= 721) {
          filter = localPokeList.sublist(649, 721);
        } else {
          filter = await pokeDio.getPokemonListByGeneration(6);
        }
        break;
      case 'Generation VII':
        if (localPokeList.any((e) => e.id == 722) &&
            localPokeList.any((e) => e.id == 802) &&
            localPokeList.length >= 802) {
          filter = localPokeList.sublist(721, 802);
        } else {
          filter = await pokeDio.getPokemonListByGeneration(7);
        }
        break;
      case 'Generation VIII':
        if (localPokeList.any((e) => e.id == 803) &&
            localPokeList.any((e) => e.id == 905) &&
            localPokeList.length >= 905) {
          filter = localPokeList.sublist(802, 905);
        } else {
          filter = await pokeDio.getPokemonListByGeneration(8);
        }
        break;
      default:
        _filterStateStream.sink.add(StatePage.DONE);
        return [];
    }
    if (filter.isNotEmpty) {
      _filterStateStream.sink.add(StatePage.FILTER);
    } else {
      _filterStateStream.sink.add(StatePage.EMPTY);
    }
    return filter;
  }

  Future<List<Pokemon>> searchByName(String name) async {
    _filterStateStream.sink.add(StatePage.LOADING);
    List<Pokemon> response = [];
    try {
      response = await pokeDio.searchPokemon(name);
      await localDex.addPokemon(response.first, 'pokemons');
    } catch (e) {
      _filterStateStream.sink.add(StatePage.EMPTY);
    }
    _filterStateStream.sink.add(StatePage.FILTER);
    return response;
  }

  Future<List<Pokemon>> setFilter(
      {required List<String> types,
      required List<String> heights,
      required List<String> weights,
      required RangeValues range}) async {
    _filterStateStream.sink.add(StatePage.FILTER);
    List<Pokemon> myList = await localDex.getPokemons('pokemons');
    List<Pokemon> filter = [];

    if (types.isNotEmpty) {
      List<Pokemon> aux = [];
      for (final item in types) {
        aux.addAll(myList.where((e) => e.type1 == item || e.type2 == item));
      }
      myList.retainWhere((e) => aux.any((a) => a.id == e.id));
    }

    if (heights.isNotEmpty) {
      List<Pokemon> aux = [];
      for (final item in heights) {
        final tam = getHeight(item);
        aux.addAll(
            myList.where((e) => e.height >= tam.first && e.height <= tam.last));
      }
      myList.retainWhere((e) => aux.any((a) => a.id == e.id));
    }

    if (weights.isNotEmpty) {
      List<Pokemon> aux = [];
      for (final item in weights) {
        final tam = getWeight(item);
        aux.addAll(
            myList.where((e) => e.weight >= tam.first && e.weight <= tam.last));
      }
      myList.retainWhere((e) => aux.any((a) => a.id == e.id));
    }

    if (range.start != 0 || range.end != 905) {
      myList.retainWhere((e) => e.id >= range.start && e.id <= range.end);
    }

    if (types.isNotEmpty ||
        heights.isNotEmpty ||
        range.start != 0 ||
        range.end != 905 ||
        weights.isNotEmpty) {
      filter.addAll(myList);
      if (filter.isEmpty) _filterStateStream.sink.add(StatePage.EMPTY);
    } else {
      _filterStateStream.sink.add(StatePage.DONE);
    }

    filter = filter.toSet().toList();
    filter.sort((a, b) => a.id.compareTo(b.id));
    return filter;
  }
}
