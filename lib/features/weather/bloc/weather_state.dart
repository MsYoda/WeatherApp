import 'package:equatable/equatable.dart';
import 'package:test_task/domain/models/cached_city.dart';
import 'package:test_task/domain/models/weather_info.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {
  const WeatherInitial();
}

class WeatherLoaded extends WeatherState {
  final CachedCity city;
  final WeatherInfo currentWeather;
  final List<WeatherInfo> weatherForecast;

  const WeatherLoaded({
    required this.city,
    required this.currentWeather,
    required this.weatherForecast,
  });

  WeatherLoaded copyWith({
    WeatherInfo? currentWeather,
    List<WeatherInfo>? weatherForecast,
    CachedCity? city,
  }) {
    return WeatherLoaded(
      city: city ?? this.city,
      currentWeather: currentWeather ?? this.currentWeather,
      weatherForecast: weatherForecast ?? this.weatherForecast,
    );
  }

  @override
  List<Object?> get props => super.props + [currentWeather, weatherForecast];
}

class WeatherLoading extends WeatherState {
  const WeatherLoading();
}

class WeatherError extends WeatherState {
  const WeatherError();
}
