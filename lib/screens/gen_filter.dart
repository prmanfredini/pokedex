import 'package:flutter/material.dart';
import 'package:pokedex/components/gen_choices.dart';
import 'package:pokedex/widgets/generation_chip.dart';

class GeneFilter extends StatefulWidget {
  final String select;
  final BuildContext context;
  final Function(String) functionButton;

  const GeneFilter({
    Key? key,
    required this.select,
    required this.context,
    required this.functionButton,
  }) : super(key: key);

  @override
  State<GeneFilter> createState() => _GeneFilterState();
}

class _GeneFilterState extends State<GeneFilter> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 415,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 10),
              const Text('Generations',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              const SizedBox(height: 10),
              const Text('Use search for generations to explore your\nPokédex!'),
              const SizedBox(height: 8),
              SizedBox(
                  height: 310,
                  width: double.maxFinite,
                  child: GenerationChip(
                      choices, widget.functionButton, widget.select)),
            ],
          ),
        ),
      ),
    );
  }
}
