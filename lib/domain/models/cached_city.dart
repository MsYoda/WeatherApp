import 'package:test_task/domain/models/city.dart';
import 'package:test_task/domain/models/coordinates.dart';

class CachedCity extends City {
  final DateTime timestamp;

  const CachedCity({
    required super.name,
    required super.countryCode,
    required super.coordinates,
    required this.timestamp,
  });

  @override
  CachedCity copyWith({
    String? name,
    String? countryCode,
    Coordinates? coordinates,
    DateTime? timestamp,
  }) {
    return CachedCity(
      name: name ?? this.name,
      countryCode: countryCode ?? this.countryCode,
      coordinates: coordinates ?? this.coordinates,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
