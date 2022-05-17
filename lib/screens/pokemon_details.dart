import 'package:flutter/material.dart';

import '../models/pokemon.dart';

class PokeDetails extends StatelessWidget {
  final Pokemon pokemon;

  const PokeDetails({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text(pokemon.nome),
      ),
    );
  }
}
