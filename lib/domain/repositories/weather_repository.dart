import 'package:test_task/domain/models/coordinates.dart';
import 'package:test_task/domain/models/weather_info.dart';

abstract interface class WeatherRepository {
  Future<WeatherInfo> getCurrentWeatherByCoordinates(Coordinates coordiantes);
  Future<List<WeatherInfo>> getForecastByCoordinates(Coordinates coordiantes);
}
