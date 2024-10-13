import 'package:hive/hive.dart';
import 'package:test_task/data/entities/coordinates_entity.dart';

part 'generated/city_entity.g.dart';

@HiveType(typeId: 2)
class CityEntity extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String countryCode;
  @HiveField(2)
  final CoordinatesEntity coordinates;

  CityEntity({
    required this.name,
    required this.countryCode,
    required this.coordinates,
  });

  factory CityEntity.fromJson(Map<String, dynamic> json) {
    return CityEntity(
      name: json['name'] as String,
      countryCode: json['countryCode'] as String,
      coordinates: CoordinatesEntity.fromJson(json['coordiantes']),
    );
  }
}
