import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/services/api_pokemon.dart';

class PokemonProvider extends ChangeNotifier {
  bool _loading = false;
  bool _hasReachedMax = false;
  int _offset = 0;
  List<Pokemon> _pokemons = [];

  bool get loading => _loading;
  bool get hasReachedMax => _hasReachedMax;
  List<Pokemon> get pokemons => _pokemons;

  ApiPokemon _apiPokemon = ApiPokemon();

  Future<void> loadData() async {
    _loading = true;
    notifyListeners();
    _pokemons = await _apiPokemon.fetchPokemons(offset: _offset);
    _offset = _pokemons.length;
    print(_offset);
    _loading = false;
    notifyListeners();
  }

  Future<void> loadMoreData() async {
    if (!_hasReachedMax) {
      List<Pokemon> result = await _apiPokemon.fetchPokemons(offset: _offset);
      if (result.isEmpty) {
        _hasReachedMax = true;
      } else {
        _pokemons.addAll(result);
        _offset = pokemons.length;
        print(_offset);
      }
      notifyListeners();
    } else {
      print('$_hasReachedMax');
    }
  }

  void resetValues() {
    _loading = false;
    _hasReachedMax = false;
    _offset = 0;
    _pokemons.clear();
  }
}
