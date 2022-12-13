import '../../../../core/params/forecast_param.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/forecase_days_entity.dart';
import '../repository/weather_repository.dart';

class GetForecastWeatherUseCase
    implements UseCase<DataState<ForecastDaysEntity>, ForecastParams> {
  final WeatherRepository weatherRepository;
  GetForecastWeatherUseCase(this.weatherRepository);

  @override
  Future<DataState<ForecastDaysEntity>> call(ForecastParams params) {
    return weatherRepository.fetchForecastWeatherData(params);
  }
}
