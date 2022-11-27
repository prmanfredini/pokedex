import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/components/camelcase.dart';
import 'package:pokedex/screens/poke_stats.dart';
import '../components/colors.dart';
import '../entities/pokemon.dart';

Widget pokeCards(Pokemon pokemon, BuildContext context, controller) {
  return Material(
    shadowColor: getColor(pokemon.type1).shade700,
    child: InkWell(
      onTap: () => bottomStats(pokemon, context, controller),
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: getColor(pokemon.type1).shade700.withOpacity(0.6),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '#${pokemon.id.toString().padLeft(3, '0')}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: getColor(pokemon.type1).shade900),
                  ),
                  Text(
                    pokemon.name.toCamelCase(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      cardType(pokemon.type1),
                      Visibility(
                        visible: pokemon.type2 != '',
                        child: cardType(pokemon.type2),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 100,
            top: -25,
            child: SizedBox(
              height: 80,
              width: 80,
              child: shaderMask("assets/patterns/6x3.svg"),
            ),
          ),
          Positioned(
            right: -10,
            child: SizedBox(
              height: 130,
              width: 140,
              child: shaderMask("assets/patterns/pokeball.svg"),
            ),
          ),
          Positioned(
            bottom: 15,
            right: 20,
            child: SizedBox(
              height: 120,
              width: 120,
              child: Image.network(pokemon.image, scale: 3.65),
            ),
          )
        ],
        clipBehavior: Clip.none,
      ),
    ),
  );
}

Card cardType(String? type) {
  return Card(
    elevation: 0,
    color: getColor(type ?? ''),
    child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        children: [
          SvgPicture.asset('assets/types/${type}.svg',
              color: Colors.white, height: 14),
          const SizedBox(width: 5),
          Text(
            type?.toCamelCase() ?? '',
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    ),
  );
}

ShaderMask shaderMask(String image) {
  return ShaderMask(
    shaderCallback: (Rect bounds) {
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.white, Colors.white.withOpacity(0)],
      ).createShader(bounds);
    },
    child: SvgPicture.asset(
      image,
      color: Colors.white.withOpacity(0.4),
    ),
  );
}
