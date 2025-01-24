import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/services/http_service.dart';

final pokemonDataProvider = FutureProvider.family<Pokemon?, String>((ref, url) async {
  HTTPService _httpService = GetIt.instance.get<HTTPService>();
  Response? res = await _httpService.get(path: url);

  if(res != null && res.data != null) {
    return Pokemon.fromJson(res.data);
  }

  return null;
});

final favPokemonProvider = StateNotifierProvider<FavPokemonProvider, List<String>>((ref){
  return FavPokemonProvider([]);
});
class FavPokemonProvider extends StateNotifier<List<String>> {
  FavPokemonProvider(super.state) {
    _setup();
  }
  Future<void> _setup() async {

  }

  void addFavPokemon(String url) {
    state = [...state, url];
  }
  void removeFavPokemon(String url) {
    state = state.where((element) => element != url).toList();
  }
}