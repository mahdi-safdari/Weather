import 'package:clean_block_floor_lint_dio/features/feature_weather/domain/entities/forecase_days_entity.dart';

import '../../../../core/params/forecast_param.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/entities/current_city_entity.dart';
import '../../domain/repository/weather_repository.dart';
import '../data_source/remote/api_provider.dart';
import '../models/current_city_model.dart';
import 'package:dio/dio.dart';

import '../models/forecast_days_model.dart';

//! Repository pattern
//! Body of the Repository class is here
class WeatherRepositoryImpl extends WeatherRepository {
  ApiProvider apiProvider;
  WeatherRepositoryImpl(this.apiProvider); //! for ( Dependency injection )

  @override //! Override Method of WeatherRepository abstract class
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(
      String cityName) async {
    try {
      //! Get current weather data with Response from Dio.dart class
      //! call API from ApiProvider method
      Response response = await apiProvider.callCurrentWeather(cityName);

      if (response.statusCode == 200) {
        CurrentCityEntity currentCityEntity =
            CurrentCityModel.fromJson(response.data);
        return DataSucsses(currentCityEntity);
      } else {
        return DataFailed(
            'Something went wrong try again ...'); //! Error Handling
      }
    } catch (e) {
      return DataFailed('Please check your connection ...'); //! Error Handling
    }
  }

  @override
  Future<DataState<ForecastDaysEntity>> fetchForecastWeatherData(
      ForecastParams params) async {
    try {
      Response response = await apiProvider.senRequest7DaysForcast(params);
      if (response.statusCode == 200) {
        ForecastDaysEntity forecastDaysEntity =
            ForecastDaysModel.fromJson(response.data);
        return DataSucsses(forecastDaysEntity);
      } else {
        return DataFailed('Something went wrong try again ...');
      }
    } catch (e) {
      return DataFailed('Please check your connection ...'); //! Error Handling

    }
  }
}
