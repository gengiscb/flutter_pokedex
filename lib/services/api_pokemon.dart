import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/models/pokemon.dart';

class ApiPokemon {
  String get urlBase => "https://pokeapi.co/api/v2/";

  Future<List<Pokemon>> fetchPokemons({int offset = 0}) async {
    String url = "${this.urlBase}pokemon?offset=$offset&limit=100";
    print(url);
    final response = await http.get(url);
    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      final dataList = data['results'] as List;
      return dataList.map((e) => Pokemon.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
