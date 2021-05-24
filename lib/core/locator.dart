import 'package:get_it/get_it.dart';

import 'services/navigator_service.dart';
import 'services/tmdb_data_service.dart';

GetIt locator = GetIt.instance;

class LocatorInjector {
  static Future<void> setupLocator() async {
    locator.registerLazySingleton(() => NavigationService());
    locator.registerLazySingleton(() => TmdbDataService());
  }
}
