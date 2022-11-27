import 'package:flutter/material.dart';

class SingleChip extends StatefulWidget {
  final List<String> reportList;
  final Function function;
  final String selectedChoice;
  final double? height;

  const SingleChip(this.reportList, this.function, this.selectedChoice,
      {Key? key, this.height})
      : super(key: key);

  @override
  _SingleChipState createState() => _SingleChipState();
}

class _SingleChipState extends State<SingleChip> {
  late String selectedChoice = widget.selectedChoice;

  _buildChoiceList() {
    List<Widget> choices = [];
    for (var item in widget.reportList) {
      choices.add(ChoiceChip(
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: SizedBox(
            width: double.maxFinite,
            height: widget.height,
            child: Center(
                child: Text(item,
                    style: TextStyle(
                        color: selectedChoice.contains(item)
                            ? Colors.white
                            : Colors.grey[700])))),
        selected: selectedChoice.contains(item),
        selectedColor: Colors.redAccent.withOpacity(0.8),
        backgroundColor: Colors.grey[300],
        elevation: selectedChoice.contains(item) ? 8 : 0,
        selectedShadowColor: Colors.redAccent,
        onSelected: (selected) {
          widget.function(item);
          setState(() {
            selectedChoice = item;
          });
          //Navigator.pop(context);
        },
      ));
    }
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 5,
      spacing: 15,
      children: _buildChoiceList(),
    );
  }
}
