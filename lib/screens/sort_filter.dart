import 'package:flutter/material.dart';
import '../widgets/single_chip.dart';

class SortFilter extends StatefulWidget {
  final String select;
  final BuildContext context;
  final Function(String) functionButtom;

  const SortFilter(
      {Key? key,
        required this.select,
        required this.context,
        required this.functionButtom,})
      : super(key: key);

  @override
  State<SortFilter> createState() => _SortFilterState();
}

class _SortFilterState extends State<SortFilter> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 16),
              const Text('Sort',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              const SizedBox(height: 10),
              const Text(
                'Sort Pokémons alphabetically or by National \nPokédex number!',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 10),
              SingleChip(choices, widget.functionButtom, widget.select, 0),
            ],
          ),
        ),
      ),
    );
  }
}
final choices = ['Smallest number first', 'Highest number first', 'A-Z', 'Z-A'];