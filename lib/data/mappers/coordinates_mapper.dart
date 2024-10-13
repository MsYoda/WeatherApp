import 'package:test_task/data/entities/coordinates_entity.dart';
import 'package:test_task/domain/models/coordinates.dart';

abstract class CoordinatesMapper {
  static Coordinates fromEntity(CoordinatesEntity entity) {
    return Coordinates(
      lat: entity.lat,
      lon: entity.lon,
    );
  }

  static CoordinatesEntity toEntity(Coordinates model) {
    return CoordinatesEntity(
      lat: model.lat,
      lon: model.lon,
    );
  }
}
