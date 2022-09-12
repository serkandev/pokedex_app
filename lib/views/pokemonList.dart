import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex_app/cubit/favoritePokemonsCubit.dart';
import 'package:pokedex_app/model/favoritePokemonModel.dart';
import 'package:pokedex_app/views/pokemonDetail.dart';
import 'package:skeletons/skeletons.dart';
import '../cubit/pokemonListCubit.dart';
import '../model/pokemonModel.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({Key? key}) : super(key: key);

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  bool searchButtonTap = false;
  bool showFavoritePokemons = false;

  @override
  void initState() {
    context.read<PokemonListCubit>().getPokemonList();
    context.read<FavoritePokemonsCubit>().getFavoritePokemons();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: showFavoritePokemons ? const Text("Favorite Pokemons") : const Text("Pokemons"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  showFavoritePokemons = !showFavoritePokemons;
                });
              },
              icon: !showFavoritePokemons
                  ? const Icon(Icons.stars_rounded, color: Colors.yellow)
                  : const Icon(Icons.home_outlined))
        ],
      ),
      body: SafeArea(
          child: Center(
        child: showFavoritePokemons
            ? BlocBuilder<FavoritePokemonsCubit, List<FavoritePokemonModel>>(builder: (context, pokelist) {
                return pokelist.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Lottie.asset(width: 250, height: 250, fit: BoxFit.cover, 'assets/empty-list.json'),
                            Column(
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        showFavoritePokemons = !showFavoritePokemons;
                                      });
                                    },
                                    child: const Text("Add your favorite pokemons")),
                                const Text("list is empty"),
                              ],
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: pokelist.length,
                        itemBuilder: ((context, index) {
                          return Card(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => PokemonDetail(
                                              name: pokelist[index].name,
                                              id: index + 1,
                                              url: pokelist[index].url,
                                              isPokemonFavorite: true,
                                            ))));
                              },
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(pokelist[index].name),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }));
              })
            : BlocBuilder<PokemonListCubit, List<PokemonModel>>(
                builder: (context, pokelist) {
                  return pokelist.length == 1
                      ? SkeletonListView()
                      : ListView.builder(
                          itemCount: pokelist.length,
                          itemBuilder: ((context, index) {
                            return Card(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => PokemonDetail(
                                                isPokemonFavorite: false,
                                                name: pokelist[index].name,
                                                id: index + 1,
                                                url: pokelist[index].url,
                                                id2: index,
                                              ))));
                                },
                                child: ListTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [Text(pokelist[index].name), const Icon(Icons.chevron_right)],
                                  ),
                                ),
                              ),
                            );
                          }));
                },
              ),
      )),
    );
  }
}
