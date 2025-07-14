// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/characters.dart';
import '../../data/repository/characters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Result> characters = [];

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<Result> getAllCharacters() {
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters: characters));
      this.characters = characters;
    });
    return characters;
  }
}
