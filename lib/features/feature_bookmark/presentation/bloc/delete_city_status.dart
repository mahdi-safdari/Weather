import 'package:equatable/equatable.dart';

abstract class DeleteCityStatus extends Equatable {}

//! Initial state
class DeleteCityInitial extends DeleteCityStatus {
  @override
  List<Object?> get props => [];
}

//! Loading state
class DeleteCityLoading extends DeleteCityStatus {
  @override
  List<Object?> get props => [];
}

//! Completed state
class DeleteCityCompleted extends DeleteCityStatus {
  final String name;

  DeleteCityCompleted(this.name);
  @override
  List<Object?> get props => [name];
}

//! Error state
class DeleteCityError extends DeleteCityStatus {
  final String? message;

  DeleteCityError(this.message);
  @override
  List<Object?> get props => [message];
}
