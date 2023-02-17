import 'package:bloc/bloc.dart';
import 'package:clean_block_floor_lint_dio/core/params/forecast_param.dart';
import 'package:clean_block_floor_lint_dio/core/resources/data_state.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/domain/use_cases/get_current_weather_usecase.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/domain/use_cases/get_forecast_weather_usecase.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/presentation/bloc/cw_status.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/presentation/bloc/fw_status.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

//! HomeEvent is imported
//! HomeState is output
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  final GetForecastWeatherUseCase getForecastWeatherUseCase;

  //! super => Initial mode of the application
  HomeBloc(this.getCurrentWeatherUseCase, this.getForecastWeatherUseCase)
      : super(
          HomeState(
            cwStatus: CwLoading(),
            fwStatus: FwLoading(),
          ),
        ) {
    //! this method on => Convert events to stream
    //! Any time call LoadCwEvent event run the method on
    on<LoadCwEvent>(
      (LoadCwEvent event, Emitter<HomeState> emit) async {
        //! emit state to Loading current weather event
        emit(
          state.copyWith(
            newCwStatus: CwLoading(),
          ),
        );

        final DataState dataState =
            await getCurrentWeatherUseCase(event.cityName);

        //! emit state to completed current weather event
        if (dataState is DataSuccess) {
          emit(
            state.copyWith(
              newCwStatus: CwCompleted(dataState.data),
            ),
          );
        }

        //! emit state to error current weather event
        if (dataState is DataFailed) {
          emit(
            state.copyWith(
              newCwStatus: CwError(dataState.error!),
            ),
          );
        }
      },
    );

    //! Load forecast weather for city event
    on<LoadFwEvent>(
      (LoadFwEvent event, Emitter<HomeState> emit) async {
        //! emit state to Loading forecast weather event
        emit(
          state.copyWith(
            newFwStatus: FwLoading(),
          ),
        );

        final DataState dataState =
            await getForecastWeatherUseCase(event.params);
        //! emit state to Completed forecast weather event
        if (dataState is DataSuccess) {
          emit(
            state.copyWith(
              newFwStatus: FwCompleted(dataState.data),
            ),
          );
        }
        //! emit state to Error forecast weather event
        if (dataState is DataFailed) {
          emit(
            state.copyWith(
              newFwStatus: FwError(dataState.error!),
            ),
          );
        }
      },
    );
  }
}
