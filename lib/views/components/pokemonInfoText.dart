import 'package:flutter/material.dart';

class PokemonInfoText extends StatelessWidget {
  PokemonInfoText({Key? key, required this.Stat, required this.StatName}) : super(key: key);

  String Stat;
  String StatName;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shadowColor: Colors.black,
        elevation: 4,
        child: ListTile(title: Text(textAlign: TextAlign.center, "$StatName : $Stat")),
      ),
    );
  }
}
