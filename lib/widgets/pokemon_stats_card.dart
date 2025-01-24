import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/pokemon_data_providers.dart';

class PokemonStatsCard extends ConsumerWidget {
  final String pokemonURL;

  const PokemonStatsCard({super.key, required this.pokemonURL});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(pokemonDataProvider(pokemonURL));
    return AlertDialog(
      title: const Text('Pokemon Stats'),
      content: pokemon.when(
          data: (data) => Column(
            mainAxisSize: MainAxisSize.min,
            children: data?.stats?.map((s) {
              return ListTile(
                title: Text(s.stat?.name?.toUpperCase() ?? ''),
                subtitle: Text(s.baseStat.toString(), style: const TextStyle(fontWeight: FontWeight.bold),),
              );
            }).toList() ?? [],
          ),
          error: (error, stackTrace) => Text('Error: $error'),
          loading: () => const CircularProgressIndicator()),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],

    );
  }
  
}