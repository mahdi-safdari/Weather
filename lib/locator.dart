import 'package:get_it/get_it.dart';
import 'features/feature_weather/data/data_source/remote/api_provider.dart';

GetIt locator = GetIt.instance;

setup() {
  locator.registerSingleton<ApiProvider>(ApiProvider());
}
