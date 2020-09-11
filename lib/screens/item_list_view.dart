import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/screens/detail_screen.dart';

class ItemListView extends StatelessWidget {
  final Pokemon pokemon;

  const ItemListView({Key key, this.pokemon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => DetailScreen(pokemon: pokemon)),
      ),
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              child: Center(
                child: Image.network(
                  pokemon.imageUrl,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/placeholder_image.png',
                      width: 60,
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      pokemon.name,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(height: 8),
                    Text(
                        'Lorem ipsum dolor sit amet, consectetur '
                        'adipiscing elit,',
                        style: Theme.of(context).textTheme.caption),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
