import 'dart:convert';

import 'package:test_task/core/config/dart_define.gen.dart';
import 'package:test_task/data/entities/coordinates_entity.dart';
import 'package:test_task/data/entities/weather_info_entity.dart';
import 'package:http/http.dart' as http;
import 'package:test_task/domain/exceptions/api_exception.dart';
import 'package:test_task/domain/exceptions/app_exception.dart';

class OpenWeatherDatasource {
  static const _openWeatherAPIUrl = 'https://api.openweathermap.org/data/2.5/';
  static const _apiKey = DartDefine.openweatherKey;

  List<WeatherInfoEntity> _weatherInfoFromForecast(Map<String, dynamic> data) {
    final List forecasts = data['list'];
    return forecasts.map(
      (forecast) {
        return WeatherInfoEntity(
          temperature: (forecast['main']['temp'] as num).round(),
          minTemperature: (forecast['main']['temp_min'] as num).round(),
          maxTemperature: (forecast['main']['temp_max'] as num).round(),
          humidity: (forecast['main']['humidity'] as num).toDouble(),
          conditionType: forecast['weather'][0]['icon'] as String,
          conditionDescription: forecast['weather'][0]['description'] as String,
          windSpeed: (forecast['wind']['speed'] as num).toDouble(),
          dateTime: DateTime.fromMillisecondsSinceEpoch((forecast['dt'] as int) * 1000),
          timezone: data['city']['timezone'] as int,
        );
      },
    ).toList();
  }

  WeatherInfoEntity _weatherInfoFromCurrent(Map<String, dynamic> data) {
    return WeatherInfoEntity(
      temperature: (data['main']['temp'] as num).round(),
      minTemperature: (data['main']['temp_min'] as num).round(),
      maxTemperature: (data['main']['temp_max'] as num).round(),
      humidity: (data['main']['humidity'] as num).toDouble(),
      conditionType: data['weather'][0]['icon'] as String,
      conditionDescription: data['weather'][0]['description'] as String,
      windSpeed: (data['wind']['speed'] as num).toDouble(),
      dateTime: DateTime.fromMillisecondsSinceEpoch((data['dt'] as int) * 1000),
      timezone: data['timezone'] as int,
    );
  }

  Future<WeatherInfoEntity> fetchWeatherByCoordinates(
      CoordinatesEntity coordiantes, String lang) async {
    final uri = Uri.parse(
      '$_openWeatherAPIUrl/weather?lat=${coordiantes.lat}&lon=${coordiantes.lon}&appid=$_apiKey&units=metric&lang=$lang',
    );

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return _weatherInfoFromCurrent(data);
      } else {
        throw ApiException(statusCode: response.statusCode.toString());
      }
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  Future<List<WeatherInfoEntity>> fetchForecastByCoordinates(
      CoordinatesEntity coordiantes, String lang) async {
    final uri = Uri.parse(
      '$_openWeatherAPIUrl/forecast?lat=${coordiantes.lat}&lon=${coordiantes.lon}&appid=$_apiKey&units=metric&cnt=7&lang=$lang',
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return _weatherInfoFromForecast(data);
      } else {
        throw ApiException(statusCode: response.statusCode.toString());
      }
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }
}
