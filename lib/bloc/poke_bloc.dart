import 'dart:async';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/services/dio_pokemon.dart';

import '../models/pokemon.dart';

class PokeBloc {
  final PokeDio pokeDio = PokeDio();
  List<Pokemon> pokeList = [];

  final _pageStateStream =
      StreamController<PagingState<int, Pokemon>>.broadcast();

  Stream<PagingState<int, Pokemon>> get streamPagingState =>
      _pageStateStream.stream;

  Future<List<Pokemon>> getPokemon(int index, pagingController) async {
    //print('get 1 pokemon');
    final response = await PokeDio().getPokemonList(index);
    pokeList.addAll(response);
    final isLastPage = index >= 1126;
    final nextPageKey = isLastPage ? null : index + 30;
    _pageStateStream.sink.add(
        PagingState(error: null, nextPageKey: nextPageKey, itemList: pokeList));

    return pokeList;
  }

  Future<List<Pokemon>> getReverseList(int index, pagingController) async {
    //print('get 1 pokemon');
    final response = await PokeDio().getPokemonList(1126 - index);
    pokeList.addAll(response);
    final isLastPage = index == 0;
    final nextPageKey = isLastPage ? null : index - 30;
    _pageStateStream.sink.add(
        PagingState(error: null, nextPageKey: nextPageKey, itemList: pokeList));

    return pokeList;
  }

  List<Pokemon> sort(String valor, List<Pokemon> localPokeList) {
    //List<Pokemon> localPokeList = [];
    //print(localPokeList);
    List<Pokemon> pokeFiltro = [];
    if (valor == 'Smallest number first') {
      //localPokeList.addAll(await getAllList());
      //localPokeList.sort((a, b) => a.id.compareTo(b.id));
      //pokeFiltro = localPokeList;
      return [];
    } else if (valor == 'Highest number first') {
      //localPokeList.addAll(await getAllList());
      pokeFiltro = localPokeList.reversed.toList();
      return pokeFiltro;
    } else if (valor == 'A-Z') {
      //localPokeList.addAll(await getAllList());
      localPokeList.sort((a, b) => a.nome.compareTo(b.nome));
      pokeFiltro = localPokeList;
      return pokeFiltro;
    } else if (valor == 'Z-A') {
      //localPokeList.addAll(await getAllList());
      localPokeList.sort((a, b) => b.nome.compareTo(a.nome));
      pokeFiltro = localPokeList;
      pokeFiltro.reversed;
      return pokeFiltro;
    }
    return pokeFiltro;
  }

  Future<List<Pokemon>> getGeneration(String valor) async {
    List<Pokemon> localPokeList = [];
    if (valor == 'Generation I') {
      final response = await pokeDio.getPokemonListByGeneration(1);
      localPokeList.addAll(response);
      return localPokeList;
    } else if (valor == 'Generation II') {
      localPokeList.addAll(await pokeDio.getPokemonListByGeneration(2));
      return localPokeList;
    } else if (valor == 'Generation III') {
      localPokeList.addAll(await pokeDio.getPokemonListByGeneration(3));
      return localPokeList;
    } else if (valor == 'Generation IV') {
      localPokeList.addAll(await pokeDio.getPokemonListByGeneration(4));
      return localPokeList;
    } else if (valor == 'Generation V') {
      localPokeList.addAll(await pokeDio.getPokemonListByGeneration(5));
      return localPokeList;
    } else if (valor == 'Generation VI') {
      localPokeList.addAll(await pokeDio.getPokemonListByGeneration(6));
      return localPokeList;
    } else if (valor == 'Generation VII') {
      localPokeList.addAll(await pokeDio.getPokemonListByGeneration(7));
      return localPokeList;
    } else if (valor == 'Generation VIII') {
      localPokeList.addAll(await pokeDio.getPokemonListByGeneration(8));
      return localPokeList;
    }
    return [];
  }

  List<Pokemon> busca(String valor, List<Pokemon> localPokeList) {
    //List<Pokemon> localPokeList = [];
    //print(localPokeList);
    List<Pokemon> pokeFiltro = [];
    if (valor == '') {
      return [];
    }
//    if (double.tryParse(valor) != null) {
//      int num = int.parse(valor);
//      if (num > 1 || num < 1226) {
//        localPokeList.addAll(await pokeDio.getPokemonDetails(num));
//        return localPokeList;
//      }
//    }
    if (valor != '') {
      pokeFiltro.addAll(localPokeList.where((e) => (e.nome).startsWith(valor)));
      return pokeFiltro;
    }

    return pokeFiltro;
  }
}
