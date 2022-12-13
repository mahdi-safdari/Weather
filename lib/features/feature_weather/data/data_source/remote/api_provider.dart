import 'package:clean_block_floor_lint_dio/core/utils/constants.dart';
import 'package:dio/dio.dart';
import '../../../../../core/params/forecast_param.dart';

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
        // 'lang': 'fa',
      },
    );
    return response;
  }

//! Forcast API 7 Days
  Future<dynamic> senRequest7DaysForcast(ForecastParams params) async {
    var response = await _dio.get(
      '$baseUrl/data/2.5/onecall',
      queryParameters: {
        'lat': params.lat,
        'lon': params.lon,
        'exclude': 'minutely,hourly',
        'appid': apiKey,
        'units': 'metric',
      },
    );
    return response;
  }
}
