import 'package:flutter/material.dart';
import 'package:pokedex/components/colors.dart';

import '../models/types.dart';
import '../widgets/multi_chip.dart';
import '../widgets/single_chip.dart';

class StatFilter extends StatefulWidget {
  final BuildContext context;
  final Function(String) functionButtom;

  const StatFilter(
      {Key? key,
      required this.context,
      required this.functionButtom})
      : super(key: key);

  @override
  State<StatFilter> createState() => _StatFilterState();
}

class _StatFilterState extends State<StatFilter> {
  @override
  Widget build(BuildContext context) {
    RangeValues _currentValues = const RangeValues(0, 1126);
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.6,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 16),
              const Text('Filters',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              const SizedBox(height: 10),
              const Text(
                'Use advanced search to explore Pokémon by \ntype, height and more!',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
              const Text('Types',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: MultiSelectChip(typeObj),
              ),
             // const SizedBox(height: 10),
              const Text('Waeknesses',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: MultiSelectChip(typeObj),
              ),
              //const SizedBox(height: 10),
              const Text('Heights',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              MultiSelectChip(heightObj),
              //const SizedBox(height: 10),
              const Text('Weights',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              MultiSelectChip(weightObj),
              //const SizedBox(height: 10),
              const Text('Number Range',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(height: 10),
              RangeSlider(
                activeColor: Colors.red,
                inactiveColor: Colors.red.withOpacity(0.2),
                max: 1126,
                values: _currentValues,
                labels: RangeLabels(
                  _currentValues.start.round().toString(),
                  _currentValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentValues = values;
                  });
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SingleChip(choices, widget.functionButtom, 'Reset',3),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
final choices = ['Reset', 'Apply'];

List<Types> heightObj = [
  Types('assets/heights/short.svg', Colors.purpleAccent.withOpacity(0.3)),
  Types('assets/heights/medium.svg', Colors.blueGrey.withOpacity(0.5)),
  Types('assets/heights/tall.svg', Colors.grey)
];
List<Types> weightObj = [
  Types('assets/weights/light.svg', Colors.greenAccent),
  Types('assets/weights/normal.svg', Colors.lightBlueAccent),
  Types('assets/weights/heavy.svg', Colors.blueGrey)
];

List<Types> typeObj = [
  Types('assets/types/bug.svg', colores('bug')),
  Types('assets/types/dark.svg', colores('dark')),
  Types('assets/types/dragon.svg', colores('dragon')),
  Types('assets/types/electric.svg', colores('electric')),
  Types('assets/types/fire.svg', colores('fire')),
  Types('assets/types/fighting.svg', colores('fighting')),
  Types('assets/types/ground.svg', colores('ground')),
  Types('assets/types/ghost.svg', colores('ghost')),
  Types('assets/types/normal.svg', colores('normal')),
  Types('assets/types/water.svg', colores('water')),
  Types('assets/types/psychic.svg', colores('psychic')),
  Types('assets/types/fairy.svg', colores('fairy')),
  Types('assets/types/rock.svg', colores('rock')),
  Types('assets/types/poison.svg', colores('poison')),
  Types('assets/types/ice.svg', colores('ice')),
  Types('assets/types/flying.svg', colores('flying')),
  Types('assets/types/steel.svg', colores('steel')),
  Types('assets/types/grass.svg', colores('grass'))
];
//}
