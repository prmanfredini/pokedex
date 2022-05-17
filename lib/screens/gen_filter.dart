import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/gene.dart';
import '../widgets/genaration_chip.dart';
import '../widgets/genaration_scrollable.dart';
import '../widgets/single_chip.dart';

class GeneFilter extends StatefulWidget {
  final String select;
  final BuildContext context;
  final Function(String) functionButtom;

  const GeneFilter(
      {Key? key,
        required this.select,
        required this.context,
        required this.functionButtom,})
      : super(key: key);

  @override
  State<GeneFilter> createState() => _GeneFilterState();
}

class _GeneFilterState extends State<GeneFilter> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 1,
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 16),
            const Text('Generations',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            const SizedBox(height: 10),
            const Text(
              'Use search for generations to explore your \nPokédex!',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: GenerationChip(choices, widget.functionButtom ,widget.select)),
                //child: GenerationScroll(choices, widget.functionButtom)),
          ],
        ),
      ),
    );
  }
}
final List<Gene> choices = [
  Gene(
      Image.asset('assets/generations/generation1/001.png'),
      Image.asset('assets/generations/generation1/004.png'),
      Image.asset('assets/generations/generation1/007.png'),
      'Generation I'),
  Gene(
      Image.asset('assets/generations/generation2/152.png'),
      Image.asset('assets/generations/generation2/155.png'),
      Image.asset('assets/generations/generation2/158.png'),
      'Generation II'),
  Gene(
      Image.asset('assets/generations/generation3/252.png'),
      Image.asset('assets/generations/generation3/255.png'),
      Image.asset('assets/generations/generation3/258.png'),
      'Generation III'),
  Gene(
      Image.asset('assets/generations/generation4/387.png'),
      Image.asset('assets/generations/generation4/390.png'),
      Image.asset('assets/generations/generation4/393.png'),
      'Generation IV'),
  Gene(
      Image.asset('assets/generations/generation5/495.png'),
      Image.asset('assets/generations/generation5/498.png'),
      Image.asset('assets/generations/generation5/501.png'),
      'Generation V'),
  Gene(
      Image.asset('assets/generations/generation6/650.png'),
      Image.asset('assets/generations/generation6/653.png'),
      Image.asset('assets/generations/generation6/656.png'),
      'Generation VI'),
  Gene(
      Image.asset('assets/generations/generation7/722.png'),
      Image.asset('assets/generations/generation7/725.png'),
      Image.asset('assets/generations/generation7/728.png'),
      'Generation VII'),
  Gene(
      Image.asset('assets/generations/generation8/810.png'),
      Image.asset('assets/generations/generation8/813.png'),
      Image.asset('assets/generations/generation8/816.png'),
      'Generation VIII'),
  ];