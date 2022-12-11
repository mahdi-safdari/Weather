import 'package:clean_block_floor_lint_dio/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CwStatus {}

class CwLoading extends CwStatus {}

class CwCompleted extends CwStatus {
  final CurrentCityEntity currentCityEntity;

  CwCompleted(this.currentCityEntity);
}

class CwError extends CwStatus {
  final String errorMessage;

  CwError(this.errorMessage);
}
