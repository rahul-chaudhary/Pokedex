import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/providers/pokemon_data_providers.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../models/pokemon.dart';

class PokemonListTile extends ConsumerWidget {
  final String pokemonURL;

  const PokemonListTile({super.key, required this.pokemonURL});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(pokemonDataProvider(pokemonURL));
    return pokemon.when(data: (data) {
      return _tile(context, isLoading: false, pokemon: data);
    }, error: (error, stack) {
      return Text('Error: $error');
    }, loading: () {
      return _tile(context, isLoading: true, pokemon: null);
    });
  }

  Widget _tile(BuildContext context,
      {required bool isLoading, Pokemon? pokemon}) {
    return Skeletonizer(
        enabled: isLoading,
        child: ListTile(
          leading: pokemon != null
            ? CircleAvatar(backgroundImage: NetworkImage(pokemon.sprites!.frontDefault!),)
          : const CircleAvatar(
            backgroundColor: Colors.lightGreen,
          ),
          title: Text(
              pokemon != null
              ? pokemon.name!.toUpperCase()
              : 'Currently Loading name for the Pokemon...'
          ),
          subtitle: Text('Has ${pokemon?.abilities?.length ?? 0} abilities'),
          trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border_rounded)),
        ));
  }
}
