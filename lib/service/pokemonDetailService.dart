import 'package:dio/dio.dart';
import 'package:pokedex_app/constants/service.dart';
import 'package:pokedex_app/model/pokemonDetailModel.dart';

class PokemonDetailService {
  Future<PokemonDetailModel> getPokemonDetail(String name) async {
    var response = await Dio().get(ServiceConstants().getPokemonDetailUrl(name));
    late PokemonDetailModel pokemon;
    if (response.statusCode == 200) {
      pokemon = PokemonDetailModel.fromJson(response.data);
    } else {
      //404
    }
    return pokemon;
  }
}
