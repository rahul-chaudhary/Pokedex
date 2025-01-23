import 'package:flutter/material.dart';
import 'package:pokedex/utils/helpers/get_screen_width_height.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Pokemon $index'),
                  );
                },),
          )
        ],
      ),
    );
  }
}
