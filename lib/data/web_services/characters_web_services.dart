import 'package:dio/dio.dart';
import '../../constants/strings.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      receiveTimeout: const Duration(seconds: 20),
      connectTimeout: const Duration(seconds: 20),
    );

    dio = Dio(options);
  }

  Future<Map<String, dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('character');
      return response.data;
    } catch (e) {
      return {};
    }
  }
}
