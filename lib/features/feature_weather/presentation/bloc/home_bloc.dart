import 'package:bloc/bloc.dart';
import 'package:clean_block_floor_lint_dio/core/resources/data_state.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/domain/use_cases/get_current_weather_usecase.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/presentation/bloc/cw_status.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;

  HomeBloc(this.getCurrentWeatherUseCase)
      : super(HomeState(cwStatus: CwLoading())) {
    on<LoadCwEvent>((event, emit) async {
      emit(state.copyWith(newCwStatus: CwLoading()));
      DataState dataState = await getCurrentWeatherUseCase(event.cityName);

      if (dataState is DataSucsses) {
        emit(state.copyWith(newCwStatus: CwCompleted(dataState.data)));
      }
      if (dataState is DataFailed) {
        emit(state.copyWith(newCwStatus: CwError(dataState.error!)));
      }
    });
  }
}
