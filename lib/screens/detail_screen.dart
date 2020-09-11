import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';

class DetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  const DetailScreen({Key key, this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details page'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.black38,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(70.0),
              child: Image.network(pokemon.imageUrl),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pokemon.name,
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Colors.black54,
                        fontSize: 30.0,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
