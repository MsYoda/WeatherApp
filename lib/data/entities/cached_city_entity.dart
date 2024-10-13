import 'package:hive/hive.dart';
import 'package:test_task/data/entities/city_entity.dart';

part 'generated/cached_city_entity.g.dart';

@HiveType(typeId: 1)
class CachedCityEntity extends HiveObject {
  @HiveField(0)
  final CityEntity city;
  @HiveField(1)
  final DateTime timestamp;

  CachedCityEntity({
    required this.city,
    required this.timestamp,
  });
}
