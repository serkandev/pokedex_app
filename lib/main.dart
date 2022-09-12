import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex_app/cubit/favoritePokemonsCubit.dart';
import 'package:pokedex_app/cubit/pokemonDetailCubit.dart';
import 'package:pokedex_app/cubit/pokemonListCubit.dart';
import 'package:pokedex_app/views/pokemonList.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => PokemonListCubit())),
        BlocProvider(create: ((context) => PokemonDetailCubit())),
        BlocProvider(create: ((context) => FavoritePokemonsCubit())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AnimatedSplashScreen(
            splash: Center(
              child: Lottie.asset("assets/splash.json"),
            ),
            nextScreen: const PokemonList()),
      ),
    );
  }
}
