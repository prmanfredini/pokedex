import 'package:flutter/material.dart';

MaterialColor colores(String tipo) {
  if (tipo == 'grass') {
    return Colors.green;
  }
  if (tipo == 'fire') {
    return Colors.red;
  }
  if (tipo == 'grass') {
    return Colors.green;
  }
  if (tipo == 'water') {
    return Colors.blue;
  }
  if (tipo == 'bug') {
    return Colors.purple;
  }
  if (tipo == 'fighting') {
    return Colors.indigo;
  }
  if (tipo == 'psychic') {
    return Colors.orange;
  }
  if (tipo == 'electric') {
    return Colors.yellow;
  }
  if (tipo == 'poison') {
    return Colors.deepPurple;
  }
  if (tipo == 'fairy') {
    return Colors.teal;
  }
  if (tipo == 'rock') {
    return Colors.brown;
  } else {
    return Colors.grey;
  }
}
