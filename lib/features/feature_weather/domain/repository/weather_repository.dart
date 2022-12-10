import 'package:clean_block_floor_lint_dio/core/resources/data_state.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/domain/entities/current_city_entity.dart';

abstract class WeatherRepository {
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(String cityName);
}
