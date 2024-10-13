import 'dart:convert';

import 'package:test_task/data/entities/city_entity.dart';
import 'package:test_task/data/entities/coordinates_entity.dart';
import 'package:test_task/data/entities/weather_info_entity.dart';
import 'package:http/http.dart' as http;
import 'package:test_task/domain/exceptions/api_exception.dart';
import 'package:test_task/domain/exceptions/app_exception.dart';

class OpenWeatherDatasource {
  static const _openWeatherWeatherAPIUrl = 'https://api.openweathermap.org/data/2.5/';
  static const _openWeatherGeocodeAPIUrl = 'https://api.openweathermap.org/geo/1.0/';
  static const _apiKey = 'dd2d47e33af0d49102831009fd2ecddd';

  List<WeatherInfoEntity> _weatherInfoFromForecast(Map<String, dynamic> data) {
    final List forecasts = data['list'];
    return forecasts.map((forecast) {
      return WeatherInfoEntity(
        temperature: (forecast['main']['temp'] as num).toInt(),
        minTemperature: (forecast['main']['temp_min'] as num).toInt(),
        maxTemperature: (forecast['main']['temp_max'] as num).toInt(),
        humidity: (forecast['main']['humidity'] as num).toDouble(),
        conditionType: forecast['weather'][0]['icon'] as String,
        conditionDescription: forecast['weather'][0]['main'] as String,
        windSpeed: (forecast['wind']['speed'] as num).toDouble(),
        dateTime: DateTime.fromMillisecondsSinceEpoch((forecast['dt'] as int) * 1000).toUtc().add(
              Duration(seconds: data['city']['timezone'] as int),
            ),
      );
    }).toList();
  }

  CityEntity _cityFromGeocode(Map<String, dynamic> data) {
    return CityEntity(
      coordinates: CoordinatesEntity(
        lat: data['lat'],
        lon: data['lon'],
      ),
      name: data['local_names']?['en'] ?? data['name'],
      countryCode: data['country'],
    );
  }

  WeatherInfoEntity _weatherInfoFromCurrent(Map<String, dynamic> data) {
    return WeatherInfoEntity(
      temperature: (data['main']['temp'] as num).toInt(),
      minTemperature: (data['main']['temp_min'] as num).toInt(),
      maxTemperature: (data['main']['temp_max'] as num).toInt(),
      humidity: (data['main']['humidity'] as num).toDouble(),
      conditionType: data['weather'][0]['icon'] as String,
      conditionDescription: data['weather'][0]['main'] as String,
      windSpeed: (data['wind']['speed'] as num).toDouble(),
      dateTime: DateTime.fromMillisecondsSinceEpoch((data['dt'] as int) * 1000).toUtc().add(
            Duration(
              seconds: data['timezone'] as int,
            ),
          ),
    );
  }

  Future<CityEntity> findCityByName(String cityName) async {
    final uri = Uri.parse(
      '$_openWeatherGeocodeAPIUrl/direct?q=$cityName&limit=1&appid=$_apiKey',
    );

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return _cityFromGeocode(data[0]);
      } else {
        throw ApiException(statusCode: response.statusCode.toString());
      }
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  Future<WeatherInfoEntity> fetchWeatherByCoordinates(CoordinatesEntity coordiantes) async {
    final uri = Uri.parse(
      '$_openWeatherWeatherAPIUrl/weather?lat=${coordiantes.lat}&lon=${coordiantes.lon}&appid=$_apiKey&units=metric',
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

  Future<List<WeatherInfoEntity>> fetchForecastByCoordinates(CoordinatesEntity coordiantes) async {
    final uri = Uri.parse(
      '$_openWeatherWeatherAPIUrl/forecast?lat=${coordiantes.lat}&lon=${coordiantes.lon}&appid=$_apiKey&units=metric&cnt=7',
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
