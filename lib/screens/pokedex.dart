import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/bloc/poke_controller.dart';
import 'package:pokedex/entities/pokemon.dart';
import 'package:pokedex/screens/gen_filter.dart';
import 'package:pokedex/screens/sort_filter.dart';
import 'package:pokedex/screens/stat_filter.dart';
import 'package:pokedex/widgets/build_appbar.dart';
import 'package:pokedex/widgets/build_stream.dart';
import 'package:pokedex/widgets/cards.dart';

class Pokedex extends StatefulWidget {
  const Pokedex({Key? key}) : super(key: key);

  @override
  State<Pokedex> createState() => _PokedexState();
}

class _PokedexState extends State<Pokedex> with TickerProviderStateMixin {
  final TextEditingController search = TextEditingController();
  final PagingController<int, Pokemon> pagingController =
      PagingController(firstPageKey: 0);
  final PokeController pokeBloc = PokeController();
  bool favorites = false;
  List<Pokemon> filterList = [];
  String selectSort = 'Smallest number first';
  String selectGene = '';
  List<String> types = [];
  List<String> heights = [];
  List<String> weights = [];
  RangeValues range = const RangeValues(0, 905);
  late AnimationController spinController;

  @override
  void initState() {
    super.initState();
    pagingController.addPageRequestListener((pageKey) async {
      await pokeBloc.getPokemon(pageKey);
    });
    pokeBloc.streamPagingState.listen((event) {
      pagingController.value = event;
    });
    spinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    )..repeat();
    search.addListener(() => getSearch(search.text));
  }

  void getSearch(String value) async {
    filterList = await pokeBloc.setFilter(
        types: types, heights: heights, weights: weights, range: range);
    filterList = await pokeBloc.search(value, list: filterList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          context,
          search,
          StatFilter(
              types: types,
              heights: heights,
              weights: weights,
              range: range,
              funcTypes: (x) => setState(() => types = x),
              funcHeights: (x) => setState(() => heights = x),
              funcWeights: (x) => setState(() => weights = x),
              funcRange: (x) => setState(() => range = x),
              onSave: (x) => setFilter(clear: x)),
          SortFilter(
            select: selectSort,
            functionButton: (value) async {
              Navigator.pop(context);
              setClear();
              selectSort = value;
              filterList = await pokeBloc.sort(value);
              setState(() {});
            },
          ),
          GeneFilter(
            select: selectGene,
            functionButton: (value) async {
              Navigator.pop(context);
              setClear();
              filterList = await pokeBloc.getGeneration(value);
              selectGene = value;
              setState(() {});
            },
            context: context,
          ),
          () async => filterList = await pokeBloc
              .searchByName(search.text)
              .whenComplete(() => setState(() {}))),
      body: RefreshIndicator(
        displacement: 70,
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1)).then((value) async {
            if (mounted) {
              reloadList(fav: favorites);
            }
          });
        },
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildStream(
                PagedListView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  pagingController: pagingController,
                  physics: const BouncingScrollPhysics(),
                  builderDelegate: PagedChildBuilderDelegate<Pokemon>(
                    itemBuilder: (context, item, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 16, right: 16),
                        child: pokeCards(item, context, spinController),
                      );
                    },
                  ),
                ),
                ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: filterList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 16, right: 16),
                        child: pokeCards(
                            filterList[index], context, spinController),
                      );
                    }),
                pokeBloc,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            setClear();
            favorites = !favorites;
            reloadList(fav: favorites);
          },
          child: !favorites
              ? const Icon(Icons.favorite_rounded)
              : const Icon(Icons.home)),
    );
  }

  void setClear() {
    types = [];
    heights = [];
    weights = [];
    range = const RangeValues(0, 905);
    FocusManager.instance.primaryFocus?.unfocus();
    search.text = '';
  }

  void clearSelect() {
    favorites = false;
    selectGene = '';
    selectSort = 'Smallest number first';
  }

  void reloadList({bool fav = false}) async {
    filterList = fav
        ? await pokeBloc.favorites(favorites)
        : await pokeBloc.setFilter(
            types: types, heights: heights, weights: weights, range: range);
    setState(() {});
  }

  Future setFilter({bool clear = false}) async {
    if (clear) setClear();
    clearSelect();
    reloadList();
  }

  @override
  void dispose() {
    search.dispose();
    pagingController.dispose();
    spinController.dispose();
    super.dispose();
  }
}
