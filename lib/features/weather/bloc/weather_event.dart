class WeatherEvent {
  const WeatherEvent();
}

class WeatherCityInputChanged extends WeatherEvent {
  final String value;

  const WeatherCityInputChanged({
    required this.value,
  });
}

class WeatherCityInputSubmitted extends WeatherEvent {}

class WeatherRefresh extends WeatherEvent {}
