import 'package:flutter/material.dart';
import 'package:pokedex/components/colors.dart';
import 'package:pokedex/entities/types.dart';

final choices = ['Reset', 'Apply'];

final List<Types> heightObj = [
  Types('assets/heights/short.svg', 'short',
      Colors.purpleAccent.withOpacity(0.3)),
  Types(
      'assets/heights/medium.svg', 'medium', Colors.blueGrey.withOpacity(0.5)),
  Types('assets/heights/tall.svg', 'tall', Colors.grey)
];

final List<Types> weightObj = [
  Types('assets/weights/light.svg', 'light', Colors.greenAccent),
  Types('assets/weights/normal.svg', 'normal', Colors.lightBlueAccent),
  Types('assets/weights/heavy.svg', 'heavy', Colors.blueGrey)
];

final List<Types> typeObj = [
  Types('assets/types/bug.svg', 'bug', getColor('bug')),
  Types('assets/types/dark.svg', 'dark', getColor('dark')),
  Types('assets/types/dragon.svg', 'dragon', getColor('dragon')),
  Types('assets/types/electric.svg', 'electric', getColor('electric')),
  Types('assets/types/fire.svg', 'fire', getColor('fire')),
  Types('assets/types/fighting.svg', 'fighting', getColor('fighting')),
  Types('assets/types/ground.svg', 'ground', getColor('ground')),
  Types('assets/types/ghost.svg', 'ghost', getColor('ghost')),
  Types('assets/types/normal.svg', 'normal', getColor('normal')),
  Types('assets/types/water.svg', 'water', getColor('water')),
  Types('assets/types/psychic.svg', 'psychic', getColor('psychic')),
  Types('assets/types/fairy.svg', 'fairy', getColor('fairy')),
  Types('assets/types/rock.svg', 'rock', getColor('rock')),
  Types('assets/types/poison.svg', 'poison', getColor('poison')),
  Types('assets/types/ice.svg', 'ice', getColor('ice')),
  Types('assets/types/flying.svg', 'flying', getColor('flying')),
  Types('assets/types/steel.svg', 'steel', getColor('steel')),
  Types('assets/types/grass.svg', 'grass', getColor('grass'))
];
