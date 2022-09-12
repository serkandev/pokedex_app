import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/model/pokemonDetailModel.dart';
import 'package:pokedex_app/service/pokemonDetailService.dart';

class PokemonDetailCubit extends Cubit<PokemonDetailModel> {
  var service = PokemonDetailService();

  PokemonDetailCubit()
      : super(PokemonDetailModel(
            abilities: [],
            baseExperience: 999,
            forms: [],
            gameIndices: [],
            height: 999,
            heldItems: [],
            id: 9999,
            isDefault: false,
            locationAreaEncounters: "locationAreaEncounters",
            moves: [],
            name: "",
            order: 999,
            pastTypes: [],
            species: Species(name: "name", url: "url"),
            sprites: Sprites(
                backDefault: "backDefault",
                backFemale: "backFemale",
                backShiny: "backShiny",
                backShinyFemale: "backShinyFemale",
                frontDefault: "frontDefault",
                frontFemale: "frontFemale",
                frontShiny: "frontShiny",
                frontShinyFemale: "frontShinyFemale",
                other: Other(
                    dreamWorld: DreamWorld(
                      frontDefault: "",
                      frontFemale: "null",
                    ),
                    home: Home(
                        frontDefault: "frontDefault",
                        frontFemale: "frontFemale",
                        frontShiny: "frontShiny",
                        frontShinyFemale: "frontShinyFemale"),
                    officialArtwork: OfficialArtwork(frontDefault: "frontDefault")),
                versions: null,
                animated: "animated"),
            stats: [],
            types: [],
            weight: 999));

  Future<void> getPokemonData(String name) async {
    var pokemon = await service.getPokemonDetail(name);
    emit(pokemon);
  }
}
