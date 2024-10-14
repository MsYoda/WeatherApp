class WeatherEvent {
  const WeatherEvent();
}

class WeatherEventWithLang extends WeatherEvent {
  final String lang;

  const WeatherEventWithLang({
    required this.lang,
  });
}

class WeatherCityInputSubmitted extends WeatherEventWithLang {
  final String value;
  const WeatherCityInputSubmitted({
    required this.value,
    required super.lang,
  });
}

class WeatherRefresh extends WeatherEventWithLang {
  const WeatherRefresh({
    required super.lang,
  });
}
