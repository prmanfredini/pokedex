import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokedex/components/colors.dart';
import 'package:pokedex/components/mensagem_centro.dart';
import 'package:pokedex/components/progress_bar.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/services/dio_pokemon.dart';

class Pokedex extends StatefulWidget {
  @override
  State<Pokedex> createState() => _PokedexState();
}

class _PokedexState extends State<Pokedex> {
  final List<PokeUrl> _suggestions = [];
  bool loading = false;
  final ScrollController _scrollController = ScrollController();

  pokeFetch() async {
    if (loading) {
      return;
    } else {
      setState(() {
        loading = true;
      });
      if (_suggestions.length <= 151) {
        await getNext().then((value) {
          if (value.isNotEmpty) {
            _suggestions.addAll(value);
          }
        }).whenComplete(() {
          loading = false;
          return _suggestions;
        });
      }
    }
  }

  Pokes() async {
    await getPokeUrl().then((value) {
      if (value.isNotEmpty) {
        _suggestions.addAll(value);
      }
    }).whenComplete(() => _suggestions);
  }

  @override
  void initState() {
    super.initState();
    Pokes();
    setState(() {});
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !loading) {
        pokeFetch();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'lib/imagens/pokedex_logo.png',
          scale: 2,
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        toolbarHeight: 100,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 24.0, right: 24, top: 2, bottom: 2),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height -
                  151,
              child: GridView.builder(
                shrinkWrap: true,
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18),
                itemCount: _suggestions.length.clamp(0, 151),
                itemBuilder: (context, index) {
                  if (_suggestions.isNotEmpty) {
                    final PokeUrl pokemon = _suggestions[index];
                    return _cards(pokemon.url);
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'lib/imagens/pokeball.png',
                          scale: 2,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 24.0),
                          child: Text(
                            'Pokemon não encontrado',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],

        ),
      ),
    );
  }

  Widget _cards(String url) {
    return FutureBuilder<Pokemon>(
        future: getCatch(url),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return ProgressBar();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData && snapshot.data != null) {
                final Pokemon pokemon = snapshot.data;
                return Material(
                  color: colores(pokemon.tipo1),
                  borderRadius: BorderRadius.circular(25),
                  child: InkWell(
                    onTap: () => {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          pokemon.nome,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Image.network(pokemon.imagem, scale: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(pokemon.tipo1),
                            Text(pokemon.tipo2 ?? ''),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
          }
          return CenteredMessage('Wild Pokemon');
        });
  }
}
