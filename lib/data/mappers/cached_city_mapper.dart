import 'package:test_task/data/entities/cached_city_entity.dart';
import 'package:test_task/data/mappers/coordinates_mapper.dart';
import 'package:test_task/domain/models/cached_city.dart';

abstract class CachedCityMapper {
  static CachedCity fromEntity(CachedCityEntity entity) {
    return CachedCity(
      coordinates: CoordinatesMapper.fromEntity(entity.city.coordinates),
      name: entity.city.name,
      countryCode: entity.city.countryCode,
      timestamp: entity.timestamp,
    );
  }
}
