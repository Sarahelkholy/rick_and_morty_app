import '../models/characters.dart';
import '../web_services/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  Future<List<Result>> getAllCharacters() async {
    final response = await charactersWebServices.getAllCharacters();
    final characters = Characters.fromJson(response);
    return characters.results;
  }
}
