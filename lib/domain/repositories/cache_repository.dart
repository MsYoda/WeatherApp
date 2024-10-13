import 'package:test_task/domain/models/cached_city.dart';
import 'package:test_task/domain/models/city.dart';

abstract interface class CacheRepository {
  Future<CachedCity> saveCity(City city);
  Future<CachedCity?> getCity();
}
