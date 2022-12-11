import 'package:clean_block_floor_lint_dio/core/utils/constants.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String apiKey = Constants.apiKeys;
  final String baseUrl = Constants.baseUrl;

  //! Current weather API CALL
  Future<dynamic> callCurrentWeather(cityName) async {
    var response = await _dio.get(
      '$baseUrl/data/2.5/weather',
      queryParameters: {
        'q': cityName,
        'appid': apiKey,
        'units': 'metric',
        //! 'lang': 'fa'  persian
      },
    );
    return response;
  }
}
