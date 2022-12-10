import 'package:clean_block_floor_lint_dio/features/feature_weather/data/data_source/remote/api_provider.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/data/repository/weather_repositoryimpl.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/domain/use_cases/get_current_weather_usecase.dart';
import 'package:flutter/material.dart';
import 'core/widgets/main_wrapper.dart';

void main() {
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
