import 'package:flutter/material.dart';
import 'package:pokedex/entities/gene.dart';

class GenerationCard extends StatelessWidget {
  final Gene generation;

  const GenerationCard(this.generation);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 8),
              blurRadius: 15,
              color: Colors.black.withOpacity(0.12),
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              constraints: BoxConstraints.expand(),
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    generation.gene,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      generation.poke1,
                      generation.poke2,
                      generation.poke3,
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
