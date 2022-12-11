import 'package:clean_block_floor_lint_dio/features/feature_weather/data/repository/weather_repositoryimpl.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/domain/repository/weather_repository.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/domain/use_cases/get_current_weather_usecase.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';
import 'features/feature_weather/data/data_source/remote/api_provider.dart';

GetIt locator = GetIt.instance;

setup() {
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
