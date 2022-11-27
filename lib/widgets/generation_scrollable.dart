import 'package:flutter/material.dart';
import '../entities/gene.dart';
import 'generation_card.dart';
import 'modal.dart';

class GenerationScroll extends StatefulWidget {
  final List<Gene> generations;
  final Function function;
  final Function(List<Gene>)? onSelectionChanged;

  GenerationScroll(this.generations, this.function, {this.onSelectionChanged});

  @override
  _GenerationScrollState createState() => _GenerationScrollState();
}

class _GenerationScrollState extends State<GenerationScroll> {
  List<Gene> selectedChoice = [];

  Widget _buildGenerations(
      BuildContext context, ScrollController scrollController) {
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;

    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.fromLTRB(26, 26, 26, 26 + safeAreaBottom),
        controller: scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.55,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: widget.generations.length,
        itemBuilder: (_, index) => GenerationCard(widget.generations[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: 0.7,
      maxChildSize: 1,
      minChildSize: 0.5,
      builder: (_, scrollController) {
        return Modal(
          title: 'Generation',
          child: _buildGenerations(context, scrollController),
        );
      },
    );
  }
}
