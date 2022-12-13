import '../../domain/use_cases/get_forecast_weather_usecase.dart';
import '../../domain/use_cases/get_current_weather_usecase.dart';
import '../../../../core/params/forecast_param.dart';
import '../../../../core/resources/data_state.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'cw_status.dart';
import 'fw_status.dart';
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

        DataState dataState = await getCurrentWeatherUseCase(event.cityName);

        //! emit state to completed current weather event
        if (dataState is DataSucsses) {
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

        DataState dataState = await getForecastWeatherUseCase(event.params);
        //! emit state to Completed forecast weather event
        if (dataState is DataSucsses) {
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
