import 'package:flutter/material.dart';
import 'package:pokedex/components/type_choices.dart';
import 'package:pokedex/widgets/multi_chip.dart';

// ignore: must_be_immutable
class StatFilter extends StatelessWidget {
  List<String> types;
  List<String> heights;
  List<String> weights;
  RangeValues range;
  final Function(List<String>) funcTypes;
  final Function(List<String>) funcHeights;
  final Function(List<String>) funcWeights;
  final Function(RangeValues) funcRange;
  final Function(bool) onSave;

  StatFilter({
    Key? key,
    required this.types,
    required this.heights,
    required this.weights,
    required this.range,
    required this.funcTypes,
    required this.funcHeights,
    required this.funcWeights,
    required this.funcRange,
    required this.onSave,
  }) : super(key: key);

  void updateFilter({bool clear = false}) {
    funcTypes(types);
    funcHeights(heights);
    funcWeights(weights);
    funcRange(range);
    onSave(clear);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Filters',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              const SizedBox(height: 10),
              const Text(
                'Use advanced search to explore Pokémon by \ntype, height and more!',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
              Text('Types', style: fontStyle()),
              MultiSelectChip(typeObj,
                  onChanged: (x) => types = x, select: types),
              Text('Heights', style: fontStyle()),
              MultiSelectChip(heightObj,
                  onChanged: (x) => heights = x, select: heights),
              Text('Weights', style: fontStyle()),
              MultiSelectChip(weightObj,
                  onChanged: (x) => weights = x, select: weights),
              Text('Number Range', style: fontStyle()),
              const SizedBox(height: 10),
              StatefulBuilder(
                builder: (BuildContext context,
                    void Function(void Function()) setState) {
                  return RangeSlider(
                    activeColor: Colors.red,
                    inactiveColor: Colors.red.withOpacity(0.2),
                    max: 905,
                    values: range,
                    divisions: 905,
                    labels: RangeLabels(range.start.round().toString(),
                        range.end.round().toString()),
                    onChanged: (RangeValues values) {
                      range = values;
                      setState(() {});
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 56),
                        backgroundColor: Colors.redAccent.withOpacity(0.8),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        updateFilter(clear: true);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Reset')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 56),
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.grey[700],
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        updateFilter();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Apply')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static TextStyle fontStyle() =>
      TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
}
