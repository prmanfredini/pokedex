import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/entities/types.dart';

class MultiSelectChip extends StatefulWidget {
  final List<Types> reportList;
  final Function(List<String>) onChanged;
  final List<String> select;

  const MultiSelectChip(this.reportList,
      {Key? key, required this.onChanged, required this.select})
      : super(key: key);

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  late List<String> selectedChoices = widget.select;
  _buildChoiceList() {
    List<Widget> choices = [];
    for (var item in widget.reportList) {
      choices.add(Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ChoiceChip(
          tooltip: item.nome,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          label: SvgPicture.asset(item.asset,
              color:
                  selectedChoices.contains(item.nome) ? Colors.white : item.cor,
              width: 16,
              height: 16),
          selected: selectedChoices.contains(item.nome),
          selectedColor: item.cor,
          backgroundColor: Colors.transparent,
          selectedShadowColor: item.cor,
          elevation: selectedChoices.contains(item.nome) ? 5 : 0,
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item.nome)
                  ? selectedChoices.remove(item.nome)
                  : selectedChoices.add(item.nome);
              widget.onChanged(selectedChoices);
            });
          },
        ),
      ));
    }
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _buildChoiceList(),
      ),
    );
  }
}
