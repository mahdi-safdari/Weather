import '../../../../core/resources/data_state.dart';
import '../../domain/entities/current_city_entity.dart';
import '../../domain/repository/weather_repository.dart';
import '../data_source/remote/api_provider.dart';
import '../models/current_city_model.dart';
import 'package:dio/dio.dart';

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
}
