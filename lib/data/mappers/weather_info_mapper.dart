import 'package:test_task/data/entities/weather_info_entity.dart';
import 'package:test_task/domain/models/weather_info.dart';

abstract class WeatherInfoMapper {
  static WeatherInfo fromEntity(WeatherInfoEntity entity) {
    return WeatherInfo(
      maxTemperature: entity.maxTemperature,
      minTemperature: entity.minTemperature,
      humidity: entity.humidity,
      conditionType: entity.conditionType,
      temperature: entity.temperature,
      conditionDescription: entity.conditionDescription,
      windSpeed: entity.windSpeed,
      dateTime: entity.dateTime,
      timezone: entity.timezone,
    );
  }

  static WeatherInfoEntity toEntity(WeatherInfo model) {
    return WeatherInfoEntity(
      maxTemperature: model.maxTemperature,
      minTemperature: model.minTemperature,
      humidity: model.humidity,
      conditionType: model.conditionType,
      temperature: model.temperature,
      conditionDescription: model.conditionDescription,
      windSpeed: model.windSpeed,
      dateTime: model.dateTime,
      timezone: model.timezone,
    );
  }
}
