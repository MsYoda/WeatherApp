import 'package:test_task/domain/models/city.dart';

abstract interface class GeocodeRepository {
  Future<List<City>> findCitiesByName({
    required String name,
    required String lang,
    required int limit,
  });
}
