part of 'bookmark_bloc.dart';

class BookmarkState extends Equatable {
  final GetCityStatus getCityStatus;
  final SaveCityStatus saveCityStatus;

  const BookmarkState({
    required this.saveCityStatus,
    required this.getCityStatus,
  });

  BookmarkState copyWith({
    GetCityStatus? newGetCityStatus,
    SaveCityStatus? newSaveCityStatus,
  }) {
    return BookmarkState(
      saveCityStatus: newSaveCityStatus ?? saveCityStatus,
      getCityStatus: newGetCityStatus ?? getCityStatus,
    );
  }

  @override
  List<Object> get props => [
        saveCityStatus,
        getCityStatus,
      ];
}
