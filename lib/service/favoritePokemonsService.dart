import 'package:flutter/material.dart';
import 'package:pokedex_app/model/favoritePokemonModel.dart';
import 'package:pokedex_app/views/pokemonList.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class favoritePokemonsService {
  var favoritePokemons = <FavoritePokemonModel>[];
  late List<FavoritePokemonModel> list;
  Future<void> addFavoritePokemon(FavoritePokemonModel pokemon, BuildContext context) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    var favoritePokemons = await getFavoritePokemons();
    bool exists = favoritePokemons.any((item) => item.name == pokemon.name);
    if (exists) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("This pokemon already exist in the favorite list")));
    } else {
      favoritePokemons.add(pokemon);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Added to list")));
    }

    List<String> favList = favoritePokemons.map((item) => json.encode(item.toMap())).toList();

    sharedPreferences.setStringList('favorite-pokemons', favList);
  }

  Future deleteFavoritePokemon(BuildContext context, FavoritePokemonModel pokemon) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    var favoritePokemons = await getFavoritePokemons();
    bool exists = favoritePokemons.any((item) => item.name == pokemon.name);
    if (exists) {
      favoritePokemons.removeWhere((item) => item.name == pokemon.name);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Deleted from list")));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => const PokemonList())));
    }
    List<String> favList = favoritePokemons.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('favorite-pokemons', favList);
  }

  Future<List<FavoritePokemonModel>> getFavoritePokemons() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    var favList = sharedPreferences.getStringList('favorite-pokemons');
    favList ?? sharedPreferences.setStringList('favorite-pokemons', []);
    var list = favList!.map((item) => FavoritePokemonModel.fromMap(json.decode(item))).toList();
    return list;
  }
}
