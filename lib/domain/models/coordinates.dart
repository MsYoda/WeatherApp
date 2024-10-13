class Coordinates {
  final double lat;
  final double lon;

  const Coordinates({
    required this.lat,
    required this.lon,
  });

  Coordinates copyWith({
    double? lat,
    double? lon,
  }) {
    return Coordinates(
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
    );
  }
}
