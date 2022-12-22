import '../../../../core/resources/data_state.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/city_entity.dart';
import '../repository/city_repository.dart';

class GetCityUseCase implements UseCase<DataState<City?>, String> {
  CityRepository cityRepository;
  GetCityUseCase(this.cityRepository);

  @override
  Future<DataState<City?>> call(String params) {
    return cityRepository.findCityByName(params);
  }
}
