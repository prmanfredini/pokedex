import 'package:flutter/material.dart';
import 'package:pokedex/database/local_storage.dart';
import 'package:pokedex/screens/pokedex.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalDex();
  runApp(PokedexApp());
}

class PokedexApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('en', ''),
      theme: ThemeData(fontFamily: 'Pokemon'),
      debugShowCheckedModeBanner: false,
      home: Pokedex(),
    );
  }
}
