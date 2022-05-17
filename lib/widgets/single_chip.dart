import 'package:flutter/material.dart';

class SingleChip extends StatefulWidget {
  final List<String> reportList;
  final Function(String)? onSelectionChanged;
  final Function function;
  String selectedChoice;
  final int size;
  SingleChip(
      this.reportList,
      this.function,
      this.selectedChoice,
      this.size,
      {this.onSelectionChanged} // +added
      );
  @override
  _SingleChipState createState() => _SingleChipState();
}

class _SingleChipState extends State<SingleChip> {
  _buildChoiceList() {
    List<Widget> choices = [];
    for (var item in widget.reportList) {
      choices.add(Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: ChoiceChip(
          padding: const EdgeInsets.symmetric(vertical: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          label: SizedBox(
              width: MediaQuery.of(context).size.width/widget.size,
              child: Center(child: Text(item, style: TextStyle(color: widget.selectedChoice.contains(item) ? Colors.white : Colors.grey[700])))),
          selected: widget.selectedChoice.contains(item),
          selectedColor: Colors.redAccent.withOpacity(0.8),
          backgroundColor: Colors.grey[200],
          elevation: widget.selectedChoice.contains(item) ? 8 : 0,
          selectedShadowColor: Colors.redAccent,
          onSelected: (selected) {
            widget.function(item);
            setState(()  {
              widget.selectedChoice = item;
            });
            //Navigator.pop(context);
          },
        ),
      ));
    }
    return choices;
  }
  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 20,
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _buildChoiceList(),
    );
  }
}