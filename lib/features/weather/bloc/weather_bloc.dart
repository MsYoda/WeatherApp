import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/domain/use_cases/city_forecast_usecase.dart';
import 'package:test_task/features/weather/bloc/weather_event.dart';
import 'package:test_task/features/weather/bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final CityForecastUseCase _cityForecastUseCase;
  WeatherBloc(this._cityForecastUseCase)
      : super(
          const WeatherInitial(),
        ) {
    on<WeatherCityInputSubmitted>(_onCityInputSubmitted);
    on<WeatherRefresh>(_onWeatherRefresh);
  }

  void _onWeatherRefresh(WeatherRefresh event, Emitter<WeatherState> emit) async {
    try {
      final data = await _cityForecastUseCase.refreshData(
        event.lang,
      );
      if (data == null) {
        emit(
          const WeatherInitial(),
        );
        return;
      }

      emit(
        WeatherLoaded(
          city: data.city,
          currentWeather: data.weather,
          weatherForecast: data.forecast,
        ),
      );
    } catch (e) {
      emit(
        const WeatherInitial(),
      );
    }
  }

  void _onCityInputSubmitted(WeatherCityInputSubmitted event, Emitter<WeatherState> emit) async {
    emit(
      const WeatherLoading(),
    );
    try {
      final data = await _cityForecastUseCase.getByCityName(
        cityName: event.value,
        lang: event.lang,
      );
      emit(
        WeatherLoaded(
          city: data.city,
          currentWeather: data.weather,
          weatherForecast: data.forecast,
        ),
      );
    } catch (e) {
      emit(
        const WeatherError(),
      );
    }
  }
}
