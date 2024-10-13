import 'package:test_task/data/datasource/hive_datasource.dart';
import 'package:test_task/data/mappers/cached_city_mapper.dart';
import 'package:test_task/data/mappers/city_mapper.dart';
import 'package:test_task/domain/models/cached_city.dart';
import 'package:test_task/domain/models/city.dart';
import 'package:test_task/domain/repositories/cache_repository.dart';

class CacheHiveRepositoryImpl implements CacheRepository {
  final HiveDatasource _hiveProvider;

  CacheHiveRepositoryImpl({
    required HiveDatasource hiveProvider,
  }) : _hiveProvider = hiveProvider;

  @override
  Future<CachedCity?> getCity() async {
    final city = await _hiveProvider.getCity();
    if (city == null) return null;
    return CachedCityMapper.fromEntity(city);
  }

  @override
  Future<CachedCity> saveCity(City city) async {
    final cachedCity = await _hiveProvider.saveCity(CityMapper.toEntity(city));
    return CachedCityMapper.fromEntity(cachedCity);
  }
}
