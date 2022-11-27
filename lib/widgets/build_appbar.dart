import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppBar buildAppBar(
    BuildContext context,
    TextEditingController search,
    Widget statFilter,
    Widget sortFilter,
    Widget geneFilter,
    VoidCallback voidCallback) {
  return AppBar(
    title: Image.asset('assets/images/pokedex_logo.png', scale: 3),
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Colors.red, Colors.blue]),
      ),
    ),
    backgroundColor: Colors.blueAccent,
    toolbarHeight: 80,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.grey[300]),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Material(
              color: Colors.grey[300],
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    tooltip:
                        "If you didn't catch yet, click here to search for it",
                    color: Colors.grey,
                    icon: const Icon(Icons.search),
                    onPressed: voidCallback,
                  ),
                  Expanded(
                    child: TextField(
                      controller: search,
                      decoration: const InputDecoration.collapsed(
                        hintText: "Search by the Pokémon's name",
                      ),
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
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            buildButton(context, statFilter, 'Stat Filter',
                'assets/icons/generation.svg'),
            buildButton(
                context, sortFilter, 'Sort Filter', 'assets/icons/sort.svg'),
            buildButton(context, geneFilter, 'Generation Filter',
                'assets/icons/filter.svg'),
          ],
        ),
      ),
    ],
  );
}

IconButton buildButton(
    BuildContext context, Widget filter, String tooltip, String image) {
  return IconButton(
    onPressed: () => showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        context: context,
        builder: (builder) => filter,
        isScrollControlled: true),
    tooltip: tooltip,
    icon: SvgPicture.asset(image, height: 24),
  );
}
