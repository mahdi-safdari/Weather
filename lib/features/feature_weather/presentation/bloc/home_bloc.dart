import '../../domain/use_cases/get_current_weather_usecase.dart';
import '../../../../core/resources/data_state.dart';
import 'package:bloc/bloc.dart';
import 'cw_status.dart';
part 'home_event.dart';
part 'home_state.dart';

//! HomeEvent is imported
//! HomeState is output
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;

  //! super => Initial mode of the application
  HomeBloc(this.getCurrentWeatherUseCase)
      : super(HomeState(cwStatus: CwLoading())) {
    //! this method on => Convert events to stream
    //! Any time call LoadCwEvent event run the method on
    on<LoadCwEvent>((LoadCwEvent event, Emitter<HomeState> emit) async {
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
