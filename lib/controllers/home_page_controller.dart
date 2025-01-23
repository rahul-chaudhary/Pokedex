import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/services/http_service.dart';
import 'package:pokedex/utils/helpers/debug_print.dart';
import '../models/page_data.dart';

class HomePageController extends StateNotifier<HomePageData> {

  final GetIt _getIt = GetIt.instance;
  late HTTPService _httpService;
  static const pokeAPIURL = 'https://pokeapi.co/api/v2/pokemon?limit=20&offset=0';
  HomePageController(super.state) {
    _httpService = _getIt.get<HTTPService>();
    _setup();
  }

  Future<void> _setup() async {
    _loadData();
  }

  Future<void> _loadData() async {
    if(state.data == null) {
     Response? response = await _httpService.get(path: pokeAPIURL);
     dbPrint('_loadData response ${response?.data}');
    } else{}
  }
}