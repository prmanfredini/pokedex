import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/models/types.dart';

class MultiSelectChip extends StatefulWidget {
  final List<Types> reportList;
  final Function(List<String>)? onSelectionChanged; // +added
  MultiSelectChip(
      this.reportList,
      {this.onSelectionChanged} // +added
      );
  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}
class _MultiSelectChipState extends State<MultiSelectChip> {
  // String selectedChoice = "";
  List<String> selectedChoices = [];
  _buildChoiceList() {
    List<Widget> choices = [];
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(7.0),
        child: ChoiceChip(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          label: SvgPicture.asset(item.asset, color: selectedChoices.contains(item.asset) ? Colors.white : item.cor),
          //labelPadding: EdgeInsets.all(10),
          selected: selectedChoices.contains(item.asset),
          selectedColor: item.cor,
          backgroundColor: Colors.transparent,
          selectedShadowColor: item.cor,
          elevation: selectedChoices.contains(item.asset) ? 5 : 0,
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item.asset)
                  ? selectedChoices.remove(item.asset)
                  : selectedChoices.add(item.asset);
              widget.onSelectionChanged != null ? (selectedChoices) :(null); // +added
            });
          },
        ),
      ));
    });
    return choices;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: _buildChoiceList(),
    );
  }
}