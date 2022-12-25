import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'get_city_status.dart';
import 'save_city_status.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  BookmarkBloc()
      : super(BookmarkState(
          saveCityStatus: SaveCityInitial(),
          getCityStatus: GetCityLoading(),
        )) {
    on<BookmarkEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
