import 'package:test_task/domain/models/city.dart';

class CachedCity extends City {
  final DateTime timestamp;

  const CachedCity({
    required super.name,
    required super.countryCode,
    required super.coordinates,
    required this.timestamp,
  });
}
