import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/data_state.dart';
import '../../domain/use_cases/get_city_usecase.dart';
import '../../domain/use_cases/save_city_usecase.dart';
import 'get_city_status.dart';
import 'save_city_status.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  GetCityUseCase getCityUseCase;
  SaveCityUseCase saveCityUseCase;
  BookmarkBloc(
    this.getCityUseCase,
    this.saveCityUseCase,
  ) : super(BookmarkState(
          saveCityStatus: SaveCityInitial(),
          getCityStatus: GetCityLoading(),
        )) {
    //! get city by name event from database
    on<GetCityByNameEvent>((event, emit) async {
      //! emit loading state
      emit(state.copyWith(newGetCityStatus: GetCityLoading()));

      DataState dataState = await getCityUseCase(event.cityName);

      //! emit complete state
      if (dataState is DataSuccess) {
        emit(
            state.copyWith(newGetCityStatus: GetCityCompleted(dataState.data)));
      }

      //! emit error state
      if (dataState is DataFailed) {
        emit(state.copyWith(newGetCityStatus: GetCityError(dataState.error!)));
      }
    });

    on<SaveCwEvent>((event, emit) async {
      //! emit loading state
      emit(state.copyWith(newSaveCityStatus: SaveCityLoading()));
      DataState dataState = await getCityUseCase(event.name);

      //! emit complete state
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newSaveCityStatus: SaveCityCompleted(dataState.data)));
      }
      //! emit error state
      if (dataState is DataFailed) {
        emit(
            state.copyWith(newSaveCityStatus: SaveCityError(dataState.error!)));
      }
    });
    on<SaveCityInitialEvent>((event, emit) async {
      emit(state.copyWith(newSaveCityStatus: SaveCityInitial()));
    });
  }
}
