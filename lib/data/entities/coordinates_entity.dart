import 'package:hive/hive.dart';

part 'generated/coordinates_entity.g.dart';

@HiveType(typeId: 0)
class CoordinatesEntity extends HiveObject {
  @HiveField(0)
  final double lat;
  @HiveField(1)
  final double lon;

  CoordinatesEntity({
    required this.lat,
    required this.lon,
  });

  factory CoordinatesEntity.fromJson(Map<String, dynamic> json) {
    return CoordinatesEntity(
      lat: json['lat'] as double,
      lon: json['lon'] as double,
    );
  }
}
