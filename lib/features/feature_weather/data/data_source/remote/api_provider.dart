import 'package:clean_block_floor_lint_dio/core/params/forecast_param.dart';
import 'package:clean_block_floor_lint_dio/core/utils/constants.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  final Dio _dio = Dio();
  //# API key for accessing the weather data
  final String apiKey = Constants.apiKeys;
  //# Base URL for API requests
  final String baseUrl = Constants.baseUrl;

  //! current weather api call
  //# This function sends an HTTP GET request to retrieve the current weather data for a given city
  //# It takes a `cityName` parameter and returns the API response
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

//! Forcast API 5 Days
  //# This function sends an HTTP GET request to retrieve the 5-day forecast data for a given location
  //# It takes a `ForecastParams` object as a parameter and returns the API response
  Future<dynamic> senRequest7DaysForcast(ForecastParams params) async {
    var response = await _dio.get(
      '$baseUrl/data/2.5/forecast',
      queryParameters: {
        'lat': params.lat,
        'lon': params.lon,
        'appid': apiKey,
        'units': 'metric',
      },
    );
    return response;
  }

  //! City name suggest API
  //# This function sends an HTTP GET request to retrieve a list of suggested city names based on a prefix string
  //# It takes a `prefix` parameter and returns the API response
  Future<dynamic> sendRequestCitySuggestion(String prefix) async {
    var response = await _dio.get(
      "http://geodb-free-service.wirefreethought.com/v1/geo/cities",
      queryParameters: {
        'limit': 7,
        'offset': 0,
        'namePrefix': prefix,
      },
    );
    return response;
  }
}
