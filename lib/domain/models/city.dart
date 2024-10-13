import 'package:test_task/domain/models/coordinates.dart';

class City {
  final String name;
  final String countryCode;
  final Coordinates coordinates;

  const City({
    required this.name,
    required this.countryCode,
    required this.coordinates,
  });

  City copyWith({
    String? name,
    String? countryCode,
    Coordinates? coordinates,
  }) {
    return City(
      name: name ?? this.name,
      countryCode: countryCode ?? this.countryCode,
      coordinates: coordinates ?? this.coordinates,
    );
  }
}
