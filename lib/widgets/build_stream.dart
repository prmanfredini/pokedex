import 'package:flutter/material.dart';
import 'package:pokedex/bloc/poke_controller.dart';
import 'package:pokedex/widgets/center_message.dart';
import 'package:pokedex/widgets/progress_bar.dart';

StreamBuilder<StatePage> buildStream(
    Widget done, Widget filter, PokeController pokeBloc) {
  return StreamBuilder<StatePage>(
    stream: pokeBloc.streamFilterState,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data == StatePage.LOADING) {
          return const ProgressBar();
        } else if (snapshot.data == StatePage.EMPTY) {
          return const CenteredMessage();
        } else if (snapshot.data == StatePage.DONE) {
          return Expanded(child: done);
        } else if (snapshot.data == StatePage.FILTER) {
          return Expanded(child: filter);
        }
      }
      return Expanded(child: done);
    },
  );
}
