import 'package:get_it/get_it.dart';
import 'package:test_task/data/datasource/geonames_datasource.dart';
import 'package:test_task/data/datasource/hive_datasource.dart';
import 'package:test_task/data/datasource/open_weather_datasource.dart';
import 'package:test_task/data/repositories/cache_hive_repository_impl.dart';
import 'package:test_task/data/repositories/geocode_open_weather_repository_impl.dart';
import 'package:test_task/data/repositories/weather_open_weather_repository_impl.dart';
import 'package:test_task/domain/repositories/cache_repository.dart';
import 'package:test_task/domain/repositories/geocode_repository.dart';
import 'package:test_task/domain/repositories/weather_repository.dart';
import 'package:test_task/domain/use_cases/city_forecast_usecase.dart';
import 'package:test_task/domain/use_cases/city_search_usecase.dart';

final appLocator = GetIt.instance;

void initDependencies() async {
  appLocator.registerLazySingleton(
    () => OpenWeatherDatasource(),
  );

  appLocator.registerLazySingleton(
    () => GeonamesDatasource(),
  );

  appLocator.registerSingletonAsync(
    () async {
      await HiveDatasource.init();
      return HiveDatasource();
    },
    dispose: (_) => HiveDatasource.dispose(),
  );

  appLocator.registerLazySingleton<CacheRepository>(
    () => CacheHiveRepositoryImpl(
      hiveProvider: appLocator.get(),
    ),
  );

  appLocator.registerLazySingleton<GeocodeRepository>(
    () => GeocodeOpenWeatherRepositoryImpl(
      geonamesDatasource: appLocator.get(),
    ),
  );
  appLocator.registerLazySingleton<WeatherRepository>(
    () => WeatherOpenWeatherRepositoryImpl(
      openWeatherProvider: appLocator.get(),
    ),
  );

  appLocator.registerLazySingleton<CityForecastUseCase>(
    () => CityForecastUseCase(
      weatherRemoteRepository: appLocator.get(),
      geocodeRepository: appLocator.get(),
      cacheRepository: appLocator.get(),
    ),
  );
  appLocator.registerLazySingleton<CitySearchUsecase>(
    () => CitySearchUsecase(
      geocodeRepository: appLocator.get(),
    ),
  );
}
