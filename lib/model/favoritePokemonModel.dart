class FavoritePokemonModel {
  final String name;
  final String url;
  final int? id;

  FavoritePokemonModel({required this.name, required this.url, required this.id});

  FavoritePokemonModel.fromMap(Map map)
      : name = map['name'],
        url = map['url'],
        id = map['id'];

  Map toMap() {
    return {'name': name, 'url': url};
  }
}
