import 'package:clean_block_floor_lint_dio/features/feature_weather/domain/entities/forecase_days_entity.dart';

import '../../../../core/params/forecast_param.dart';
import '../../../../core/resources/data_state.dart';
import '../../data/models/suggest_city_model.dart';
import '../entities/current_city_entity.dart';

abstract class WeatherRepository {
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(String cityName);

  Future<DataState<ForecastDaysEntity>> fetchForecastWeatherData(
      ForecastParams params);

  Future<List<Data>> fetchSuggestData(cityName);
}
