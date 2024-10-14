import 'package:test_task/domain/models/city.dart';
import 'package:test_task/domain/repositories/geocode_repository.dart';

class CitySearchUsecase {
  final GeocodeRepository _geocodeRepository;

  CitySearchUsecase({
    required GeocodeRepository geocodeRepository,
  }) : _geocodeRepository = geocodeRepository;

  Future<List<City>> search({
    required String input,
    required String lang,
  }) async {
    return _geocodeRepository.findCitiesByName(
      name: input,
      lang: lang,
      limit: 5,
    );
  }
}
