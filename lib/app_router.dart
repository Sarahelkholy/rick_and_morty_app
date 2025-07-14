import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'business_logic/cubit/characters_cubit.dart';
import 'constants/strings.dart';
import 'data/models/characters.dart';
import 'data/repository/characters_repository.dart';
import 'data/web_services/characters_web_services.dart';
import 'presentation/screens/character_details.dart';
import 'presentation/screens/characters_screen.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext contxt) => charactersCubit,
            child: const CharactersScreen(),
          ),
        );
      case characterDetailsScreen:
        final character = settings.arguments as Result;
        return MaterialPageRoute(
            builder: (_) => CharacterDetails(
                  character: character,
                ));
    }
    return null;
  }
}
