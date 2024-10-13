import 'package:test_task/domain/models/city.dart';

abstract interface class GeocodeRepository {
  Future<City> findCityByName(String name);
}
