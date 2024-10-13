import 'package:equatable/equatable.dart';
import 'package:test_task/domain/models/cached_city.dart';
import 'package:test_task/domain/models/weather_info.dart';

abstract class WeatherState extends Equatable {
  final String cityInput;

  const WeatherState({
    required this.cityInput,
  });

  WeatherState copyWith({String? cityInput});

  @override
  List<Object?> get props => [
        cityInput,
      ];
}

class WeatherInitial extends WeatherState {
  const WeatherInitial({
    required super.cityInput,
  });

  @override
  WeatherInitial copyWith({
    String? cityInput,
  }) {
    return WeatherInitial(
      cityInput: cityInput ?? this.cityInput,
    );
  }
}

class WeatherLoaded extends WeatherState {
  final CachedCity city;
  final WeatherInfo currentWeather;
  final List<WeatherInfo> weatherForecast;

  const WeatherLoaded({
    required super.cityInput,
    required this.city,
    required this.currentWeather,
    required this.weatherForecast,
  });

  @override
  WeatherLoaded copyWith({
    String? cityInput,
    WeatherInfo? currentWeather,
    List<WeatherInfo>? weatherForecast,
    CachedCity? city,
  }) {
    return WeatherLoaded(
      city: city ?? this.city,
      cityInput: cityInput ?? this.cityInput,
      currentWeather: currentWeather ?? this.currentWeather,
      weatherForecast: weatherForecast ?? this.weatherForecast,
    );
  }

  @override
  List<Object?> get props => super.props + [currentWeather, weatherForecast];
}

class WeatherLoading extends WeatherState {
  const WeatherLoading({
    required super.cityInput,
  });

  @override
  WeatherLoading copyWith({
    String? cityInput,
  }) {
    return WeatherLoading(
      cityInput: cityInput ?? this.cityInput,
    );
  }
}

class WeatherError extends WeatherState {
  const WeatherError({
    required super.cityInput,
  });

  @override
  WeatherError copyWith({
    String? cityInput,
  }) {
    return WeatherError(
      cityInput: cityInput ?? this.cityInput,
    );
  }
}
