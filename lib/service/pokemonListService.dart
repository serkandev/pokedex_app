import 'package:dio/dio.dart';
import 'package:pokedex_app/constants/service.dart';
import 'package:pokedex_app/model/pokemonListModel.dart';
import 'package:pokedex_app/model/pokemonModel.dart';

class PokemonListService {
  Future<List<PokemonModel>> getPokemonList() async {
    var response = await Dio().get(ServiceConstants.apiUrl);
    var pokemonList = <PokemonModel>[];
    if (response.statusCode == 200) {
      var pokedexData = PokemonListModel.fromJson(response.data);
      if (pokedexData is Object) {
        for (int i = 0; i < ServiceConstants.pokemonCountLimit; i++) {
          var pokeData = pokedexData.results;
          pokemonList.add(PokemonModel(name: pokeData[i].name, url: pokeData[i].url));
        }
      }
    }
    return pokemonList;
  }
}
