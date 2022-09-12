import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/model/favoritePokemonModel.dart';
import 'package:pokedex_app/service/favoritePokemonsService.dart';

class FavoritePokemonsCubit extends Cubit<List<FavoritePokemonModel>> {
  FavoritePokemonsCubit() : super([]);
  var service = favoritePokemonsService();
  Future<void> getFavoritePokemons() async {
    var favoritePokemons = <FavoritePokemonModel>[];
    favoritePokemons = await service.getFavoritePokemons();
    emit(favoritePokemons);
  }

  Future<void> addFavoritePokemon(BuildContext context, FavoritePokemonModel pokemon) async {
    await service.addFavoritePokemon(pokemon, context);
    getFavoritePokemons();
  }

  Future<void> deleteFavoritePokemon(BuildContext context, FavoritePokemonModel pokemon) async {
    await service.deleteFavoritePokemon(context, pokemon);
    getFavoritePokemons();
  }
}
