
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/screens/pokedex.dart';

void main() async {
  runApp(PokedexApp());
}

class PokedexApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('en', ''),
      debugShowCheckedModeBanner: false,
      home: Pokedex(),
    );
  }
}
