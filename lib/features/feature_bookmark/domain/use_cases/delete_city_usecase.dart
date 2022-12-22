import '../../../../core/resources/data_state.dart';
import '../../../../core/use_case/use_case.dart';
import '../repository/city_repository.dart';

class DeleteCityUseCase implements UseCase<DataState<String>, String> {
  CityRepository cityRepository;
  DeleteCityUseCase(this.cityRepository);

  @override
  Future<DataState<String>> call(String params) {
    return cityRepository.deleteCityByName(params);
  }
}
