part of 'bookmark_bloc.dart';

class BookmarkState extends Equatable {
  final GetCityStatus getCityStatus;
  final SaveCityStatus saveCityStatus;
  final DeleteCityStatus deleteCityStatus;
  final GetAllCityStatus getAllCityStatus;

  const BookmarkState({
    required this.deleteCityStatus,
    required this.getAllCityStatus,
    required this.saveCityStatus,
    required this.getCityStatus,
  });

  BookmarkState copyWith({
    GetCityStatus? newGetCityStatus,
    SaveCityStatus? newSaveCityStatus,
    DeleteCityStatus? newDeleteCityStatus,
    GetAllCityStatus? newGetAllCityStatus,
  }) {
    return BookmarkState(
      saveCityStatus: newSaveCityStatus ?? saveCityStatus,
      getCityStatus: newGetCityStatus ?? getCityStatus,
      deleteCityStatus: newDeleteCityStatus ?? deleteCityStatus,
      getAllCityStatus: newGetAllCityStatus ?? getAllCityStatus,
    );
  }

  @override
  List<Object> get props => [
        saveCityStatus,
        getCityStatus,
        getAllCityStatus,
        deleteCityStatus,
      ];
}
