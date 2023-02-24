import 'package:clean_block_floor_lint_dio/core/params/forecast_param.dart';
import 'package:clean_block_floor_lint_dio/core/resources/data_state.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/data/data_source/remote/api_provider.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/data/models/current_city_model.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/data/models/forecast_days_model.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/domain/entities/forecase_days_entity.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/domain/entities/suggest_city_entity.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/domain/repository/weather_repository.dart';
import 'package:dio/dio.dart';

//! Repository pattern
//! Body of the Repository class is here
class WeatherRepositoryImpl extends WeatherRepository {
  ApiProvider apiProvider;
  WeatherRepositoryImpl(this.apiProvider); //! for ( Dependency injection )

  @override //! Override Method of WeatherRepository abstract class
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(
    String cityName,
  ) async {
    try {
      //! Get current weather data with Response from Dio.dart class
      //! call API from ApiProvider method
      final Response response = await apiProvider.callCurrentWeather(cityName);

      if (response.statusCode == 200) {
        final CurrentCityEntity currentCityEntity =
            CurrentCityModel.fromJson(response.data);
        return DataSuccess(currentCityEntity);
      } else {
        return DataFailed(
          'Something went wrong try again ...',
        ); //! Error Handling
      }
    } catch (e) {
      return DataFailed('Please check your connection ...'); //! Error Handling
    }
  }

  @override
  Future<DataState<ForecastDaysEntity>> fetchForecastWeatherData(
    ForecastParams params,
  ) async {
    try {
      final Response response =
          await apiProvider.senRequest7DaysForcast(params);
      if (response.statusCode == 200) {
        final ForecastDaysEntity forecastDaysEntity =
            ForecastDaysModel.fromJson(response.data);
        return DataSuccess(forecastDaysEntity);
      } else {
        return DataFailed('Something went wrong try again ...');
      }
      //! Error Handling
    } catch (e) {
      return DataFailed('Please check your connection ...');
    }
  }

  @override
  Future<List<Data>> fetchSuggestData(dynamic cityName) async {
    try {
      final Response response =
          await apiProvider.sendRequestCitySuggestion(cityName);
      final SuggestCityEntity suggestCityEntity =
          SuggestCityModel.fromJson(response.data);
      return suggestCityEntity.data!;
    } catch (e) {
      return [];
    }
  }
}
