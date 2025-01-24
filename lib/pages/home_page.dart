import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/models/page_data.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/utils/helpers/debug_print.dart';
import 'package:pokedex/utils/helpers/get_screen_width_height.dart';
import 'package:pokedex/widgets/pokemon_list_tile.dart';
import '../controllers/home_page_controller.dart';

final homePageControllerProvider = StateNotifierProvider<HomePageController, HomePageData>((ref){
  return HomePageController(HomePageData.initial());
});

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late HomePageController _homePageController;
  late HomePageData _homePageData;
  final ScrollController allPokemonListSC = ScrollController();

  @override
  void initState() {
    super.initState();
    allPokemonListSC.addListener(_scrollListener);
  }

  @override
  void dispose() {
    allPokemonListSC.removeListener(_scrollListener);
    allPokemonListSC.dispose();
    super.dispose();

  }

  void _scrollListener() {
    if(allPokemonListSC.offset >= allPokemonListSC.position.maxScrollExtent * 1 && !allPokemonListSC.position.outOfRange) {
      _homePageController.loadData();
      dbPrint('Reached ENd of list');
    }
  }
  @override
  Widget build(BuildContext context) {
    _homePageController = ref.watch(homePageControllerProvider.notifier);
    _homePageData = ref.watch(homePageControllerProvider);

    return Scaffold(
      body: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: getScreenWidth(context),
            padding: EdgeInsets.symmetric(horizontal: getScreenWidth(context) * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                allPokemonList(context),
              ],
            ),
          ),
        ) );
  }

  Widget allPokemonList(BuildContext context) {
    return SizedBox(
      width: getScreenWidth(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'All Pokemon',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: getScreenHeight(context) * 0.6,
            child: ListView.builder(
              itemCount: _homePageData.data?.results?.length ?? 0,
                controller: allPokemonListSC,
                itemBuilder: (context, index) {
                PokemonListResult? pokemon = _homePageData.data?.results?[index];
                  return PokemonListTile(pokemonURL: pokemon!.url!);
                },),
          )
        ],
      ),
    );
  }
}
