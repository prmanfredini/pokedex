import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/components/camelcase.dart';
import 'package:pokedex/components/colors.dart';
import 'package:pokedex/database/local_storage.dart';
import 'package:pokedex/entities/pokemon.dart';

Future<dynamic> bottomStats(
    Pokemon pokemon, BuildContext context, controller) async {
  final localDex = LocalDex();
  final auxList = await localDex.getPokemons('favorites');
  bool checked = auxList.any((e) => e.id == pokemon.id);
  final color = getColor(pokemon.type1);

  return showModalBottomSheet(
    backgroundColor: color.shade300,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
    context: context,
    builder: (builder) => SizedBox(
      height: 350,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -140,
            child: SizedBox(
              height: 200,
              width: 200,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, color.withOpacity(0)],
                  ).createShader(bounds);
                },
                child: RotationTransition(
                  turns: controller,
                  child: SvgPicture.asset(
                    "assets/patterns/pokeball.svg",
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -35,
            child: SizedBox(
              height: 180,
              width: 180,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.white, Colors.white.withOpacity(0)],
                  ).createShader(bounds);
                },
                child: SvgPicture.asset(
                  "assets/patterns/6x3.svg",
                  color: color,
                ),
              ),
            ),
          ),
          Positioned(
            top: -145,
            child: SizedBox(
              height: 200,
              width: 200,
              child: Image.network(pokemon.image, scale: 2),
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: StatefulBuilder(
              builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return SizedBox(
                  child: IconButton(
                      onPressed: () async {
                        setState(() => checked = !checked);
                        auxList.any((e) => e.id == pokemon.id)
                            ? await localDex.removePokemon(pokemon, 'favorites')
                            : await localDex.addPokemon(pokemon, 'favorites');
                      },
                      icon: checked
                          ? const Icon(Icons.favorite_rounded)
                          : const Icon(Icons.favorite_border_rounded)),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 35),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      pokemon.name.toCamelCase(),
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Weight: ${pokemon.weight / 10} kg',
                            style: const TextStyle(fontSize: 16)),
                        Text('Height: ${pokemon.height / 10} m',
                            style: const TextStyle(fontSize: 16)),
                      ]),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 180
                        : 60,
                    child: ListView.builder(
                        itemCount: pokemon.stats.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    pokemon.stats[index].name.toCamelCase(),
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    pokemon.stats[index].base.toString(),
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10)
                            ],
                          );
                        }),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
