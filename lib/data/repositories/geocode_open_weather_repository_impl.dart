import 'package:test_task/data/datasource/geonames_datasource.dart';
import 'package:test_task/data/mappers/city_mapper.dart';
import 'package:test_task/domain/models/city.dart';
import 'package:test_task/domain/repositories/geocode_repository.dart';

class GeocodeOpenWeatherRepositoryImpl implements GeocodeRepository {
  final GeonamesDatasource _geonamesDatasource;

  GeocodeOpenWeatherRepositoryImpl({
    required GeonamesDatasource geonamesDatasource,
  }) : _geonamesDatasource = geonamesDatasource;

  @override
  Future<List<City>> findCitiesByName({
    required String name,
    required String lang,
    required int limit,
  }) async {
    final entitiesList = await _geonamesDatasource.findCitiesStartWith(
      cityName: name,
      lang: lang,
      limit: limit,
    );
    return entitiesList.map(CityMapper.fromEntity).toList();
  }
}
