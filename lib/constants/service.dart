class ServiceConstants {
  static const String apiUrl = "https://pokeapi.co/api/v2/pokemon?limit=$pokemonCountLimit";
  static const int pokemonCountLimit = 1153;

  String getPokemonDetailUrl(String name) {
    return "https://pokeapi.co/api/v2/pokemon/$name";
  }
}
