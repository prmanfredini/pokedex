import 'package:flutter/material.dart';

MaterialColor getColor(String type) {
  if (type == 'grass') {
    return Colors.green;
  }
  if (type == 'fire') {
    return Colors.orange;
  }
  if (type == 'flying') {
    return Colors.blueGrey;
  }
  if (type == 'water') {
    return Colors.blue;
  }
  if (type == 'ice') {
    return Colors.lightBlue;
  }
  if (type == 'bug') {
    return Colors.lightGreen;
  }
  if (type == 'fighting') {
    return Colors.red;
  }
  if (type == 'psychic') {
    return Colors.teal;
  }
  if (type == 'electric') {
    return Colors.yellow;
  }
  if (type == 'poison') {
    return Colors.purple;
  }
  if (type == 'fairy') {
    return Colors.pink;
  }
  if (type == 'ghost') {
    return Colors.cyan;
  }
  if (type == 'ground') {
    return Colors.deepOrange;
  }
  if (type == 'dragon') {
    return Colors.indigo;
  }
  if (type == 'dark') {
    return Colors.deepPurple;
  }
  if (type == 'steel') {
    return Colors.lime;
  }
  if (type == 'rock') {
    return Colors.brown;
  } else {
    return Colors.grey;
  }
}
