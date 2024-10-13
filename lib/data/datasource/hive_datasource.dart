import 'package:hive/hive.dart';
import 'package:test_task/data/entities/cached_city_entity.dart';
import 'package:test_task/data/entities/city_entity.dart';
import 'package:test_task/data/entities/coordinates_entity.dart';
import 'package:test_task/data/entities/weather_info_entity.dart';

class HiveDatasource {
  static late final Box<CachedCityEntity> _cachedCity;

  static Future<void> init() async {
    Hive.registerAdapter(CachedCityEntityAdapter());
    Hive.registerAdapter(CityEntityAdapter());
    Hive.registerAdapter(CoordinatesEntityAdapter());
    Hive.registerAdapter(WeatherInfoEntityAdapter());

    _cachedCity = await Hive.openBox('cached_city');
  }

  Future<CachedCityEntity> saveCity(CityEntity city) async {
    final cachedCity = CachedCityEntity(
      city: city,
      timestamp: DateTime.now(),
    );

    await _cachedCity.put('city', cachedCity);
    return cachedCity;
  }

  Future<CachedCityEntity?> getCity() async {
    return _cachedCity.get('city');
  }

  static void dispose() async {
    _cachedCity.close();
  }
}
