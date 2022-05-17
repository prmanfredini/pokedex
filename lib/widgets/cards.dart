
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/components/capitalized.dart';

import '../components/colors.dart';
import '../models/pokemon.dart';

Widget cards(Pokemon pokemon , BuildContext context) {
  return Material(
    shadowColor: colores(pokemon.tipo1).shade700,
    child: InkWell(
      onTap: () {
        print('muda pagina');
      },
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: colores(pokemon.tipo1).shade700.withOpacity(0.6),
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
                        color: colores(pokemon.tipo1).shade900),
                  ),
                  Text(
                    pokemon.nome.capitalize(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        margin: EdgeInsets.zero,
                          elevation: 0,
                          color: colores(pokemon.tipo1),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/types/${pokemon.tipo1}.svg',
                                  color: Colors.white,
                                  height: 14,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  pokemon.tipo1.capitalize(),
                                  style: const TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                          )),
                      Visibility(
                        visible: pokemon.tipo2 != '',
                        child: Card(
                          elevation: 0,
                          color: colores(pokemon.tipo2 ?? ''),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/types/${pokemon.tipo2}.svg',
                                  color: Colors.white,
                                  height: 14,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  pokemon.tipo2?.capitalize() ?? '',
                                  style: const TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left:  140,//MediaQuery.of(context).size.width * 0.25,
            top:  -28,// MediaQuery.of(context).size.width * -0.065,
            child: SizedBox(
              height: 80,
              width: 80,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white.withOpacity(0.005),
                    ],
                  ).createShader(bounds);
                },
                child: SizedBox.square(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: SvgPicture.asset(
                      "assets/patterns/6x3.svg",
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: -10,//MediaQuery.of(context).size.width * -0.02 ,
            child: SizedBox(
              height: 130,
              width: 140,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white.withOpacity(0.005),
                    ],
                  ).createShader(bounds);
                },
                child: SizedBox.square(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: SvgPicture.asset(
                      "assets/patterns/pokeball.svg",
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 15, //MediaQuery.of(context).size.height * 0.02 ,
            right: 20, //MediaQuery.of(context).size.width * 0.02,
            //left: 310,
            //top: -16,
            child: SizedBox(
              height: 120,
              width: 120,
              // child: Image.network(pokemon.imagem, scale: 3.65), // default pic (alterar no response do json)
              child: SvgPicture.network(pokemon.imagem,height: 120, width: 100,), // dreampic (alterar no response do json)
            ),
          )
        ],
        clipBehavior: Clip.none,
      ),
    ),
  );
}
