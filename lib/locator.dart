import 'package:get_it/get_it.dart';
import 'features/feature_weather/data/data_source/remote/api_provider.dart';
import 'features/feature_weather/data/repository/weather_repositoryimpl.dart';
import 'features/feature_weather/domain/repository/weather_repository.dart';
import 'features/feature_weather/domain/use_cases/get_current_weather_usecase.dart';
import 'features/feature_weather/presentation/bloc/home_bloc.dart';

GetIt locator = GetIt.instance;
//! Dependency injection with get_it
setup() {
  //! API provider
  locator.registerSingleton<ApiProvider>(ApiProvider());

  //! Repositories
  locator
      .registerSingleton<WeatherRepository>(WeatherRepositoryImpl(locator()));

  //! use Case
  locator.registerSingleton<GetCurrentWeatherUseCase>(
      GetCurrentWeatherUseCase(locator()));

  //! Bloc
  locator.registerSingleton<HomeBloc>(HomeBloc(locator()));
}
