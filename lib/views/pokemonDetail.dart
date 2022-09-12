import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/cubit/pokemonDetailCubit.dart';
import 'package:pokedex_app/model/favoritePokemonModel.dart';
import 'package:pokedex_app/model/pokemonDetailModel.dart';
import 'package:pokedex_app/views/components/pokemonInfoText.dart';

import '../cubit/favoritePokemonsCubit.dart';
import 'components/pokemonImage.dart';

class PokemonDetail extends StatefulWidget {
  const PokemonDetail({
    Key? key,
    required this.id,
    this.name,
    required this.isPokemonFavorite,
    this.url,
    this.id2,
  }) : super(key: key);

  @override
  final id;
  final name;
  final url;
  final id2;
  final bool isPokemonFavorite;
  @override
  State<PokemonDetail> createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  @override
  void initState() {
    getPokemonData();
    super.initState();
  }

  void getPokemonData() async {
    await context.read<PokemonDetailCubit>().getPokemonData(widget.name);
  }

  var favoritePokemons = <FavoritePokemonModel>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(223, 224, 228, 1),
      appBar: AppBar(
        title: const Text("Pokemon Detail"),
      ),
      body: SafeArea(child: BlocBuilder<PokemonDetailCubit, PokemonDetailModel>(
        builder: (context, Pokemon) {
          return Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Container(
                child: Card(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: [
                      PokemonImage(url: Pokemon.sprites.frontDefault),
                      Expanded(
                        flex: 7,
                        child: Column(
                          children: [
                            PokemonInfoText(Stat: Pokemon.name, StatName: "Name"),
                            PokemonInfoText(
                                Stat: Pokemon.types.isNotEmpty ? " ${Pokemon.types.first.type.name}" : "",
                                StatName: "Type"),
                            PokemonInfoText(Stat: "${Pokemon.weight}", StatName: "Weight"),
                            PokemonInfoText(Stat: "${Pokemon.height}", StatName: "Height"),
                            PokemonInfoText(
                                Stat: Pokemon.stats.isNotEmpty ? " ${Pokemon.stats[0].baseStat}" : "", StatName: "Hp"),
                            PokemonInfoText(
                                Stat: Pokemon.stats.isNotEmpty ? "${Pokemon.stats[1].baseStat}" : "",
                                StatName: "Attack"),
                            PokemonInfoText(
                                Stat: Pokemon.stats.isNotEmpty ? "${Pokemon.stats[2].baseStat}" : "",
                                StatName: "Defense"),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (widget.isPokemonFavorite) {
                                        context.read<FavoritePokemonsCubit>().deleteFavoritePokemon(context,
                                            FavoritePokemonModel(name: widget.name, url: widget.url, id: widget.id2));
                                      } else {
                                        context.read<FavoritePokemonsCubit>().addFavoritePokemon(context,
                                            FavoritePokemonModel(name: widget.name, url: widget.url, id: widget.id));
                                      }
                                    },
                                    child: widget.isPokemonFavorite
                                        ? const Text("Remove from favorites")
                                        : const Text("Add to favorites")))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      )),
    );
  }
}
