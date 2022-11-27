import 'package:flutter/material.dart';

class CenteredMessage extends StatelessWidget {
  const CenteredMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset("assets/images/pokeball.png", scale: 3),
          const SizedBox(height: 15),
          const Text(
            'Pokemon not found',
            style: TextStyle(fontSize: 24),
          )
        ],
      ),
    );
  }
}
