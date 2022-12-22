import 'package:clean_block_floor_lint_dio/features/feature_bookmark/domain/repository/city_repository.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/city_entity.dart';

class SaveCityUseCase implements UseCase<DataState<City>, String> {
  CityRepository cityRepository;
  SaveCityUseCase(this.cityRepository);

  @override
  Future<DataState<City>> call(String params) {
    return cityRepository.saveCityToDB(params);
  }
}
