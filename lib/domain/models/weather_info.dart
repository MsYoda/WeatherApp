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

  WeatherInfo copyWith({
    int? temperature,
    int? minTemperature,
    int? maxTemperature,
    double? humidity,
    String? conditionType,
    String? conditionDescription,
    double? windSpeed,
    DateTime? dateTime,
  }) {
    return WeatherInfo(
      temperature: temperature ?? this.temperature,
      minTemperature: minTemperature ?? this.minTemperature,
      maxTemperature: maxTemperature ?? this.maxTemperature,
      humidity: humidity ?? this.humidity,
      conditionType: conditionType ?? this.conditionType,
      conditionDescription: conditionDescription ?? this.conditionDescription,
      windSpeed: windSpeed ?? this.windSpeed,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
