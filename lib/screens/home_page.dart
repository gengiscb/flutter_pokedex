import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/providers/auth.dart';
import 'package:pokedex/providers/pokemon_provider.dart';
import 'package:pokedex/screens/item_list_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _controller = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );

  @override
  void initState() {
    super.initState();
    final initProvider = Provider.of<PokemonProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initProvider.resetValues();
      initProvider.loadData();
    });
    _controller.addListener(() {
      var isEnd = _controller.offset == _controller.position.maxScrollExtent;
      if (isEnd) {
        initProvider.loadMoreData();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool loading = Provider.of<PokemonProvider>(context).loading;
    bool hasReachedMax = Provider.of<PokemonProvider>(context).hasReachedMax;
    List<Pokemon> pokemons = Provider.of<PokemonProvider>(context).pokemons;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.power,
            ),
            onPressed: () =>
                Provider.of<AuthProvider>(context, listen: false).signOut(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: loading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                controller: _controller,
                itemCount:
                    hasReachedMax ? pokemons.length : pokemons.length + 1,
                itemBuilder: (context, index) {
                  return index >= pokemons.length
                      ? Center(child: CircularProgressIndicator())
                      : ItemListView(pokemon: pokemons[index]);
                },
              ),
      ),
    );
  }
}
