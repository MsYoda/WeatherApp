class WeatherEvent {
  const WeatherEvent();
}

class WeatherCityInputChanged extends WeatherEvent {
  final String value;

  const WeatherCityInputChanged({
    required this.value,
  });
}

class WeatherEventWithLang extends WeatherEvent {
  final String lang;

  const WeatherEventWithLang({
    required this.lang,
  });
}

class WeatherCityInputSubmitted extends WeatherEventWithLang {
  const WeatherCityInputSubmitted({
    required super.lang,
  });
}

class WeatherRefresh extends WeatherEventWithLang {
  const WeatherRefresh({
    required super.lang,
  });
}
