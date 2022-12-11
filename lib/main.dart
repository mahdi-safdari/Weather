import 'features/feature_weather/domain/use_cases/get_current_weather_usecase.dart';
import 'features/feature_weather/data/repository/weather_repositoryimpl.dart';
import 'features/feature_weather/data/data_source/remote/api_provider.dart';
import 'core/widgets/main_wrapper.dart';
import 'package:flutter/material.dart';
import 'locator.dart';

void main() async {
  //! Dependency injection with get_it
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    GetCurrentWeatherUseCase getCurrentWeatherUseCase =
        GetCurrentWeatherUseCase(WeatherRepositoryImpl(ApiProvider()));

    getCurrentWeatherUseCase('tehran');

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainWrapper(),
    );
  }
}
