class WeatherInfo {
  final int temperature;
  final int minTemperature;
  final int maxTemperature;
  final double humidity;
  final String conditionType;
  final String conditionDescription;
  final double windSpeed;
  final DateTime dateTime;

  const WeatherInfo({
    required this.maxTemperature,
    required this.minTemperature,
    required this.humidity,
    required this.conditionType,
    required this.temperature,
    required this.conditionDescription,
    required this.windSpeed,
    required this.dateTime,
  });
}
