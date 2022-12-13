import '../../domain/entities/forecase_days_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class FwStatus extends Equatable {}

//! Loading state
class FwLoading extends FwStatus {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

//! Completed state
class FwCompleted extends FwStatus {
  final ForecastDaysEntity forecastDaysEntity;

  FwCompleted(this.forecastDaysEntity);
  @override
  // TODO: implement props
  List<Object?> get props => [forecastDaysEntity];
}

//! Error state
class FwError extends FwStatus {
  final String messeage;

  FwError(this.messeage);

  @override
  // TODO: implement props
  List<Object?> get props => [messeage];
}
