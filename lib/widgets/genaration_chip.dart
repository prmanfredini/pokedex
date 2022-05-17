import 'package:flutter/material.dart';
import '../models/gene.dart';

class GenerationChip extends StatefulWidget {
  final List<Gene> reportList;
  final Function function;
  String selectedChoice;
  final Function(String)? onSelectionChanged; // +added

  GenerationChip(this.reportList, this.function, this.selectedChoice,
      {this.onSelectionChanged} // +added
      );

  @override
  _GenerationChipState createState() => _GenerationChipState();
}

class _GenerationChipState extends State<GenerationChip> {

  _buildChoiceList() {
    List<Widget> choices = [];
    widget.reportList.forEach((item) {
      choices.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child:
        //GenerationCard(item)
        ChoiceChip(
          padding: const EdgeInsets.all(24),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          //label: Text(item.gene),
          label: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(item.gene),
              SizedBox(height: 15,),
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
          selected: widget.selectedChoice == item.gene,
          selectedColor: Colors.redAccent.withOpacity(0.8),
          backgroundColor: Colors.grey[200],
          elevation: widget.selectedChoice == item.gene ? 8 : 0,
          selectedShadowColor: Colors.redAccent,
          onSelected: (selected) {
            Navigator.pop(context);
            //widget.function(item.gene);
            setState(()  {
              //widget.selectedChoice = item.gene;
              widget.selectedChoice == item.gene
                  ? widget.selectedChoice = 'reset'
                  : widget.selectedChoice = item.gene;
              widget.onSelectionChanged != null ? widget.selectedChoice : null;
            });
            widget.function(widget.selectedChoice);

          },
        ),
      ));
    });
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
