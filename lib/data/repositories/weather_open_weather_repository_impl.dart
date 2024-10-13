import 'package:test_task/data/mappers/coordinates_mapper.dart';
import 'package:test_task/data/mappers/weather_info_mapper.dart';
import 'package:test_task/data/datasource/open_weather_datasource.dart';
import 'package:test_task/domain/models/coordinates.dart';
import 'package:test_task/domain/models/weather_info.dart';
import 'package:test_task/domain/repositories/weather_repository.dart';

class WeatherOpenWeatherRepositoryImpl implements WeatherRepository {
  final OpenWeatherDatasource _openWeatherProvider;

  WeatherOpenWeatherRepositoryImpl({
    required OpenWeatherDatasource openWeatherProvider,
  }) : _openWeatherProvider = openWeatherProvider;

  @override
  Future<WeatherInfo> getCurrentWeatherByCoordinates(Coordinates coordiantes, String lang) async {
    final data = await _openWeatherProvider.fetchWeatherByCoordinates(
      CoordinatesMapper.toEntity(coordiantes),
      lang,
    );
    return WeatherInfoMapper.fromEntity(data);
  }

  @override
  Future<List<WeatherInfo>> getForecastByCoordinates(Coordinates coordiantes, String lang) async {
    final data = await _openWeatherProvider.fetchForecastByCoordinates(
        CoordinatesMapper.toEntity(coordiantes), lang);
    return data.map(WeatherInfoMapper.fromEntity).toList();
  }
}
