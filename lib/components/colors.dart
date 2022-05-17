import 'package:flutter/material.dart';

MaterialColor colores(String tipo) {
  if (tipo == 'grass') {
    return Colors.green;
  }
  if (tipo == 'fire') {
    return Colors.orange;
  }
  if (tipo == 'flying') {
    return Colors.blueGrey;
  }
  if (tipo == 'water') {
    return Colors.blue;
  }
  if (tipo == 'ice') {
    return Colors.lightBlue;
  }
  if (tipo == 'bug') {
    return Colors.lightGreen;
  }
  if (tipo == 'fighting') {
    return Colors.red;
  }
  if (tipo == 'psychic') {
    return Colors.teal;
  }
  if (tipo == 'electric') {
    return Colors.yellow;
  }
  if (tipo == 'poison') {
    return Colors.purple;
  }
  if (tipo == 'fairy') {
    return Colors.pink;
  }
  if (tipo == 'ghost') {
    return Colors.cyan;
  }
  if (tipo == 'ground') {
    return Colors.deepOrange;
  }
  if (tipo == 'dragon') {
    return Colors.indigo;
  }
  if (tipo == 'dark') {
    return Colors.deepPurple;
  }
   if (tipo == 'steel') {
    return Colors.lime;
  }
  if (tipo == 'rock') {
    return Colors.brown;
  } else {
    return Colors.grey;
  }
}
