import 'package:test_task/data/entities/city_entity.dart';
import 'package:test_task/data/mappers/coordinates_mapper.dart';
import 'package:test_task/domain/models/city.dart';

abstract class CityMapper {
  static City fromEntity(CityEntity entity) {
    return City(
      coordinates: CoordinatesMapper.fromEntity(entity.coordinates),
      name: entity.name,
      countryCode: entity.countryCode,
    );
  }

  static CityEntity toEntity(City model) {
    return CityEntity(
      coordinates: CoordinatesMapper.toEntity(model.coordinates),
      name: model.name,
      countryCode: model.countryCode,
    );
  }
}
