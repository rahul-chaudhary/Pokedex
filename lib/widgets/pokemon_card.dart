import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/providers/pokemon_data_providers.dart';
import 'package:pokedex/utils/helpers/get_screen_width_height.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../models/pokemon.dart';

class PokemonCard extends ConsumerWidget {
  final String pokemonURL;
  late FavPokemonProvider _favPokemonProvider;
  PokemonCard({super.key, required this.pokemonURL});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _favPokemonProvider = ref.watch(favPokemonProvider.notifier);
    final pokemon = ref.watch(pokemonDataProvider(pokemonURL));
    return pokemon.when(data: (data) {
      return _card(context, isLoading: false, pokemon: data);
    }, error: (error, stackTrace) {
      return Text('Error: $error');
    }, loading: () {
      return _card(context, isLoading: true, pokemon: null);
    });
  }

  Widget _card(BuildContext context,
      {required bool isLoading, required Pokemon? pokemon}) {
    return Skeletonizer(
      enabled: isLoading,
      ignoreContainers: true,
      containersColor: Colors.white,
      child: InkWell(
        splashFactory: InkRipple.splashFactory,
        splashColor: Colors.white.withOpacity(0.5),
        onTap: () {

        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                spreadRadius: 2,
                offset: const Offset(0, 0),
              )
            ],
            gradient: const LinearGradient(
                colors: [Colors.lightGreen, Colors.green],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      pokemon?.name?.toUpperCase() ?? 'Pokemon Name',
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Text(
                    '#${pokemon?.id}',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              ),
              Expanded(
                  child: CircleAvatar(
                    radius: getScreenHeight(context) * 0.07,
                    child: pokemon != null
                        ? Image.network(pokemon.sprites!.frontDefault!)
                        : const Icon(Icons.pets),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Abilities: ${pokemon?.abilities?.length ?? 0}',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),

                   IconButton(
                       onPressed: () {
                          _favPokemonProvider.removeFavPokemon(pokemonURL);
                       },
                       icon:const Icon(
                         Icons.favorite_rounded,
                         color: Colors.red,
                       ), ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
