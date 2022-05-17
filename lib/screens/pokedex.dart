
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/bloc/poke_bloc.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/screens/sort_filter.dart';
import 'package:pokedex/screens/stat_filter.dart';

import '../components/progress_bar.dart';
import '../widgets/cards.dart';
import 'gen_filter.dart';


class Pokedex extends StatefulWidget {
  @override
  State<Pokedex> createState() => _PokedexState();
}

class _PokedexState extends State<Pokedex> {
  final TextEditingController busca = TextEditingController();
  final PagingController<int, Pokemon> pagingController =
      PagingController(firstPageKey: 0);
  final PokeBloc pokeBloc = PokeBloc();
  List<Pokemon> localPokeList = [];
  List<Pokemon> filtroPokeList = [];
  bool filtrar = false;
  String selectSort = 'Smallest number first';
  String selectGene = '';
  String selectFilter = 'Smallest number first';

  @override
  void initState() {
    super.initState();
    pagingController.addPageRequestListener((pageKey) {
      pokeBloc.getPokemon(pageKey, pagingController);
    });
    pokeBloc.streamPagingState.listen((event) {
      pagingController.value = event;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/imagens/pokedex_logo.png',
          scale: 3,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Colors.red, Colors.blue]),
          ),
        ),
        //centerTitle: true,
        backgroundColor: Colors.blueAccent,
        toolbarHeight: 80,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Material(
                  color: Colors.grey[300],
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        color: Colors.grey,
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          // realizar a busca
                          print(busca.text);
                        },
                      ),
                      Expanded(
                        child: TextField(
                          controller: busca,
                          decoration: const InputDecoration.collapsed(
                            hintText: 'What Pokémon are you looking for?',
                          ),
                          onChanged: (valor)  {
                            //final response =
                            filtroPokeList = pokeBloc.busca(valor, localPokeList);
                            filtroPokeList.isNotEmpty ? filtrar =  true : filtrar = false;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        actions: [
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(right: 8),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    print("Stat Filter");
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        context: context,
                        builder: (builder) => StatFilter(
                              functionButtom: (valor) {
                                //criar função do filtro
                                print(valor);
                              },
                              context: context,
                            ));
                  },
                  constraints: BoxConstraints(minHeight: 10, minWidth: 10),
                  icon: SvgPicture.asset(
                    'assets/icons/generation.svg',
                    height: 24,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    print("Sort Filter");
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        context: context,
                        builder: (builder) => SortFilter(
                          select: selectSort,
                          functionButtom: (valor) {
                            //criar função ordenação
                            selectSort = valor;
                            filtroPokeList = pokeBloc.sort(valor, localPokeList);
                            filtroPokeList.isNotEmpty ? filtrar =  true : filtrar = false;
                            setState(() {});
                            print(valor);
                          },
                          context: context,
                        ));
                  },
                  constraints: BoxConstraints(minHeight: 10, minWidth: 10),
                  icon: SvgPicture.asset(
                    'assets/icons/sort.svg',
                    height: 24,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    print("Generation Filter");
                   showModalBottomSheet(
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(25.0),
                       ),
                       context: context,
                       builder: (builder) => GeneFilter(
                         select: selectGene,
                         functionButtom: (valor) async {
                           valor != 'reset' ? filtrar =  true : filtrar = false;
                           valor != 'reset' ? _loadingDialog(context) : null;
                           final response = await pokeBloc.getGeneration(valor);
                           filtroPokeList = response;
                           selectGene = valor;
                           filtroPokeList.sort((a, b) => a.id.compareTo(b.id));
                           filtroPokeList.isNotEmpty? Navigator.pop(context) : null;
                           setState(() {
                           });
                           print(valor);
                         },
                         context: context,
                       ));
                  },
                  constraints: BoxConstraints(minHeight: 10, minWidth: 10),
                  icon: SvgPicture.asset(
                    'assets/icons/filter.svg',
                    height: 24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            children: [
              Visibility(
                visible: !filtrar,
                child: Expanded(
                  child: PagedListView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    pagingController: pagingController,
                    physics: const BouncingScrollPhysics(),
                    builderDelegate: PagedChildBuilderDelegate<Pokemon>(
                      itemBuilder: (context, item, index) {
                        localPokeList.contains(item) ? null : localPokeList.add(item);
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: cards(item, context),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: filtrar,
                  child: Expanded(
                    child: ListView.builder(
                        itemCount: filtroPokeList.length,
                        itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: cards(filtroPokeList[index], context),
                      );
                    }),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _loadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
              height: 150,
              width: 100,
              child: ProgressBar()),
        );
      },
    );
  }
}