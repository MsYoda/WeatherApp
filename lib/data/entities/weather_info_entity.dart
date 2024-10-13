import 'package:hive/hive.dart';

part 'generated/weather_info_entity.g.dart';

@HiveType(typeId: 3)
class WeatherInfoEntity extends HiveObject {
  @HiveField(0)
  final int temperature;
  @HiveField(1)
  final int minTemperature;
  @HiveField(2)
  final int maxTemperature;
  @HiveField(3)
  final double humidity;
  @HiveField(4)
  final String conditionType;
  @HiveField(5)
  final String conditionDescription;
  @HiveField(6)
  final double windSpeed;
  @HiveField(7)
  final DateTime dateTime;

  WeatherInfoEntity({
    required this.maxTemperature,
    required this.minTemperature,
    required this.humidity,
    required this.conditionType,
    required this.temperature,
    required this.conditionDescription,
    required this.windSpeed,
    required this.dateTime,
  });

  factory WeatherInfoEntity.fromJson(Map<String, dynamic> json) {
    return WeatherInfoEntity(
      temperature: json['temperature'] as int,
      minTemperature: json['minTemperature'] as int,
      maxTemperature: json['maxTemperature'] as int,
      humidity: (json['humidity'] as num).toDouble(),
      conditionType: json['conditionType'] as String,
      conditionDescription: json['conditionDescription'] as String,
      windSpeed: (json['windSpeed'] as num).toDouble(),
      dateTime: DateTime.parse(json['dateTime'] as String),
    );
  }
}
