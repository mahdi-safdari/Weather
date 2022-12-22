import '../../../../core/resources/data_state.dart';
import '../../domain/entities/city_entity.dart';
import '../../domain/repository/city_repository.dart';
import '../data_source/local/city_dao.dart';

class CityRepositoryImpl extends CityRepository {
  CityDao cityDao;
  CityRepositoryImpl(this.cityDao);
  @override
  Future<DataState<City>> saveCityToDB(String cityName) async {
    try {
      //! check city exist or not
      City? checkCity = await cityDao.findCityByName(cityName);
      if (checkCity != null) {
        return DataFailed('$cityDao has already existed');
      }
      //! insert city into database
      City city = City(name: cityName);
      await cityDao.insertCity(city);
      return DataSuccess(city);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<City>>> getAllCityFromDB() async {
    try {
      List<City> cities = await cityDao.getAllCity();
      return DataSuccess(cities);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<City?>> findCityByName(String name) async {
    try {
      City? city = await cityDao.findCityByName(name);
      return DataSuccess(city);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<String>> deleteCityByName(String name) async {
    try {
      await cityDao.deleteCityByName(name);
      return DataSuccess(name);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
