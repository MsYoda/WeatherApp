import 'package:test_task/domain/models/cached_city.dart';
import 'package:test_task/domain/models/weather_info.dart';
import 'package:test_task/domain/repositories/cache_repository.dart';
import 'package:test_task/domain/repositories/geocode_repository.dart';
import 'package:test_task/domain/repositories/weather_repository.dart';

class CityForecastUseCase {
  final WeatherRepository _weatherRemoteRepository;
  final GeocodeRepository _geocodeRepository;
  final CacheRepository _cacheRepository;

  CityForecastUseCase({
    required WeatherRepository weatherRemoteRepository,
    required GeocodeRepository geocodeRepository,
    required CacheRepository cacheRepository,
  })  : _weatherRemoteRepository = weatherRemoteRepository,
        _geocodeRepository = geocodeRepository,
        _cacheRepository = cacheRepository;

  Future<
      ({
        CachedCity city,
        WeatherInfo weather,
        List<WeatherInfo> forecast,
      })> getByCityName(String cityName, String lang) async {
    final city = (await _geocodeRepository.findCitiesByName(cityName, lang, 1))[0];
    final weather = await _weatherRemoteRepository.getCurrentWeatherByCoordinates(
      city.coordinates,
      lang,
    );
    final forecast = await _weatherRemoteRepository.getForecastByCoordinates(
      city.coordinates,
      lang,
    );
    forecast.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    final cachedCity = await _cacheRepository.saveCity(city);

    return (
      city: cachedCity,
      forecast: forecast,
      weather: weather,
    );
  }

  Future<
      ({
        CachedCity city,
        WeatherInfo weather,
        List<WeatherInfo> forecast,
      })?> refreshData(String lang) async {
    var cachedCity = await _cacheRepository.getCity();
    if (cachedCity == null) return null;

    final weather = await _weatherRemoteRepository.getCurrentWeatherByCoordinates(
      cachedCity.coordinates,
      lang,
    );
    final forecast = await _weatherRemoteRepository.getForecastByCoordinates(
      cachedCity.coordinates,
      lang,
    );

    cachedCity = await _cacheRepository.saveCity(cachedCity);

    return (
      city: cachedCity,
      forecast: forecast,
      weather: weather,
    );
  }
}
