import 'package:test_task/data/mappers/city_mapper.dart';
import 'package:test_task/data/datasource/open_weather_datasource.dart';
import 'package:test_task/domain/models/city.dart';
import 'package:test_task/domain/repositories/geocode_repository.dart';

class GeocodeOpenWeatherRepositoryImpl implements GeocodeRepository {
  final OpenWeatherDatasource _openWeatherProvider;

  GeocodeOpenWeatherRepositoryImpl({
    required OpenWeatherDatasource openWeatherProvider,
  }) : _openWeatherProvider = openWeatherProvider;

  @override
  Future<City> findCityByName(String name) async {
    final entity = await _openWeatherProvider.findCityByName(name);
    return CityMapper.fromEntity(entity);
  }
}
