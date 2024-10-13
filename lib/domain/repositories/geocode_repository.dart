import 'package:test_task/domain/models/city.dart';

abstract interface class GeocodeRepository {
  Future<List<City>> findCitiesByName(String name, String lang, int limit);
}
