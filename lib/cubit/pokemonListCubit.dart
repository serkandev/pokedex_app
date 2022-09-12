import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/model/pokemonModel.dart';
import 'package:pokedex_app/service/pokemonListService.dart';

class PokemonListCubit extends Cubit<List<PokemonModel>> {
  PokemonListCubit() : super(<PokemonModel>[PokemonModel(name: "Loading..", url: "")]);

  var pokeData = PokemonListService();
  var pokemonList = <PokemonModel>[];

  Future<void> getPokemonList() async {
    pokemonList = await pokeData.getPokemonList();
    emit(pokemonList);
  }
}
