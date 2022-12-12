import 'package:flutter/material.dart';
import '../../domain/entities/current_city_entity.dart';

//! Every field inside CwStatus (and its subclasses) must be final.
@immutable
abstract class CwStatus {}

//! Loading status
class CwLoading extends CwStatus {}

//! Completed status
class CwCompleted extends CwStatus {
  //! get currentCityEntity for UI
  final CurrentCityEntity currentCityEntity;

  CwCompleted(this.currentCityEntity);
}

//! Error status
class CwError extends CwStatus {
  final String errorMessage;

  CwError(this.errorMessage);
}
