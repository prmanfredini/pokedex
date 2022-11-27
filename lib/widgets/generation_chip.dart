import 'package:flutter/material.dart';
import '../entities/gene.dart';

class GenerationChip extends StatefulWidget {
  final List<Gene> reportList;
  final Function function;
  final String selectedChoice;
  final Function(String)? onSelectionChanged;

  const GenerationChip(this.reportList, this.function, this.selectedChoice,
      {Key? key, this.onSelectionChanged})
      : super(key: key);

  @override
  _GenerationChipState createState() => _GenerationChipState();
}

class _GenerationChipState extends State<GenerationChip> {
  late String selectedChoice = widget.selectedChoice;

  _buildChoiceList() {
    List<Widget> choices = [];
    for (var item in widget.reportList) {
      choices.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: ChoiceChip(
          padding: const EdgeInsets.all(16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          label: Column(
            children: [
              Text(item.gene, overflow: TextOverflow.visible),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: item.poke1),
                  Expanded(child: item.poke2),
                  Expanded(child: item.poke3),
                ],
              ),
            ],
          ),
          selected: selectedChoice == item.gene,
          selectedColor: Colors.redAccent.withOpacity(0.8),
          backgroundColor: Colors.grey[200],
          elevation: selectedChoice == item.gene ? 8 : 0,
          selectedShadowColor: Colors.redAccent,
          onSelected: (selected) {
            setState(() {
              selectedChoice == item.gene
                  ? selectedChoice = 'reset'
                  : selectedChoice = item.gene;
              widget.onSelectionChanged != null ? selectedChoice : null;
            });
            widget.function(selectedChoice);
          },
        ),
      ));
    }
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 2 / 1.5),
      children: _buildChoiceList(),
    );
  }
}
