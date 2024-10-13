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
      })> getByCityName(String cityName) async {
    final city = await _geocodeRepository.findCityByName(cityName);
    final weather = await _weatherRemoteRepository.getCurrentWeatherByCoordinates(
      city.coordinates,
    );
    final forecast = await _weatherRemoteRepository.getForecastByCoordinates(
      city.coordinates,
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
      })?> refreshData() async {
    final cachedCity = await _cacheRepository.getCity();
    if (cachedCity == null) return null;

    final weather = await _weatherRemoteRepository.getCurrentWeatherByCoordinates(
      cachedCity.coordinates,
    );
    final forecast = await _weatherRemoteRepository.getForecastByCoordinates(
      cachedCity.coordinates,
    );

    return (
      city: cachedCity,
      forecast: forecast,
      weather: weather,
    );
  }
}
