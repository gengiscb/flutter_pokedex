class Pokemon {
  final String id;
  final String name;
  final String imageUrl;

  Pokemon({
    this.id,
    this.name,
    this.imageUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final url = json['url'];
    final chunks = url.split('/');
    var id = chunks[6];
    return Pokemon(
      id: id,
      name: json['name'],
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
    );
  }
}
