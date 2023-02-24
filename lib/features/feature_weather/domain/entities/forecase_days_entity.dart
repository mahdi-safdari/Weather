import 'package:equatable/equatable.dart';
import '../../data/models/forecast_days_model.dart';

class ForecastDaysEntity extends Equatable {
  final String? cod;
  final int? message;
  final int? cnt;
  final List<ListElement>? list;
  final City? city;

  const ForecastDaysEntity({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        cod,
        message,
        cnt,
        list,
        city,
      ];

  @override
  // TODO: implement stringify
  bool? get stringify => true;
}
