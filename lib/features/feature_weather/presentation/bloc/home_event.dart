part of 'home_bloc.dart';

abstract class HomeEvent {}

//! event get weather city name
class LoadCwEvent extends HomeEvent {
  final String cityName;

  LoadCwEvent(this.cityName);
}

class LoadFwEvent extends HomeEvent {
  final ForecastParams params;

  LoadFwEvent(this.params);
}
