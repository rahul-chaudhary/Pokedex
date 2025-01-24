import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/services/database_service.dart';
import 'package:pokedex/services/http_service.dart';
import 'package:pokedex/utils/constants/app_key.dart';

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

  final DatabaseService _databaseService = GetIt.instance.get<DatabaseService>();
  FavPokemonProvider(super.state) {
    _setup();
  }
  Future<void> _setup() async {
    List<String>? result = await _databaseService.getList(AppKey.favPokemonListKey);
    state = result ?? [];
  }

  void addFavPokemon(String url) {
    state = [...state, url];
    _databaseService.saveList(AppKey.favPokemonListKey, state);
  }
  void removeFavPokemon(String url) {
    state = state.where((element) => element != url).toList();
    _databaseService.saveList(AppKey.favPokemonListKey, state);
  }
}