import 'package:clean_block_floor_lint_dio/features/feature_bookmark/data/repository/city_repositoryimpl.dart';
import 'package:clean_block_floor_lint_dio/features/feature_bookmark/domain/repository/city_repository.dart';
import 'package:get_it/get_it.dart';
import 'features/feature_bookmark/data/data_source/local/database.dart';
import 'features/feature_bookmark/domain/use_cases/delete_city_usecase.dart';
import 'features/feature_bookmark/domain/use_cases/get_all_usecase.dart';
import 'features/feature_bookmark/domain/use_cases/get_city_usecase.dart';
import 'features/feature_bookmark/domain/use_cases/save_city_usecase.dart';
import 'features/feature_bookmark/presentation/bloc/bookmark_bloc.dart';
import 'features/feature_weather/data/data_source/remote/api_provider.dart';
import 'features/feature_weather/data/repository/weather_repositoryimpl.dart';
import 'features/feature_weather/domain/repository/weather_repository.dart';
import 'features/feature_weather/domain/use_cases/get_current_weather_usecase.dart';
import 'features/feature_weather/domain/use_cases/get_forecast_weather_usecase.dart';
import 'features/feature_weather/presentation/bloc/home_bloc.dart';

GetIt locator = GetIt.instance;
//! Dependency injection with get_it
setup() async {
  //! API provider
  locator.registerSingleton<ApiProvider>(ApiProvider());
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  locator.registerSingleton<AppDatabase>(database);

  //! Repositories
  locator
      .registerSingleton<WeatherRepository>(WeatherRepositoryImpl(locator()));
  locator
      .registerSingleton<CityRepository>(CityRepositoryImpl(database.cityDao));

  //! current weather use case
  locator.registerSingleton<GetCurrentWeatherUseCase>(
      GetCurrentWeatherUseCase(locator()));

  //! forecast weather use case
  locator.registerSingleton<GetForecastWeatherUseCase>(
      GetForecastWeatherUseCase(locator()));
  locator.registerSingleton<GetCityUseCase>(GetCityUseCase(locator()));
  locator.registerSingleton<SaveCityUseCase>(SaveCityUseCase(locator()));
  locator.registerSingleton<GetAllCityUseCase>(GetAllCityUseCase(locator()));
  locator.registerSingleton<DeleteCityUseCase>(DeleteCityUseCase(locator()));

  //! Bloc
  locator.registerSingleton<HomeBloc>(HomeBloc(locator(), locator()));
  locator.registerSingleton<BookmarkBloc>(
      BookmarkBloc(locator(), locator(), locator(), locator()));
}
