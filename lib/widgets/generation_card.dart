import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/gene.dart';

class GenerationCard extends StatelessWidget {
  const GenerationCard(this.generation);

  final Gene generation;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      //final height = constraints.maxHeight;

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
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(),
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
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
//            Positioned(
//              bottom: -height * 0.136,
//              right: -height * 0.03,
//              child: SvgPicture.asset(
//                  "assets/patterns/pokeball.svg",
//                  color: Colors.white.withOpacity(0.4),
//                width: height * 0.754,
//                height: height * 0.754,
//                ),
//            ),
          ],
        ),
      );
    });
  }
}
