import 'package:flutter/material.dart';

class PokemonImage extends StatelessWidget {
  final String url;
  const PokemonImage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(flex: 3, child: Container(child: Image.network(width: 200, fit: BoxFit.contain, url)));
  }
}
