import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/domain/use_cases/city_forecast_usecase.dart';
import 'package:test_task/features/weather/bloc/weather_event.dart';
import 'package:test_task/features/weather/bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final CityForecastUseCase _cityForecastUseCase;
  WeatherBloc(this._cityForecastUseCase)
      : super(
          const WeatherInitial(
            cityInput: '',
          ),
        ) {
    on<WeatherCityInputChanged>(_onCityInputChanged);
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
          WeatherInitial(cityInput: state.cityInput),
        );
        return;
      }

      emit(
        WeatherLoaded(
          cityInput: state.cityInput,
          city: data.city,
          currentWeather: data.weather,
          weatherForecast: data.forecast,
        ),
      );
    } catch (e) {
      emit(
        WeatherInitial(cityInput: state.cityInput),
      );
    }
  }

  void _onCityInputChanged(WeatherCityInputChanged event, Emitter<WeatherState> emit) {
    emit(
      state.copyWith(
        cityInput: event.value,
      ),
    );
  }

  void _onCityInputSubmitted(WeatherCityInputSubmitted event, Emitter<WeatherState> emit) async {
    emit(
      WeatherLoading(
        cityInput: state.cityInput,
      ),
    );
    try {
      final data = await _cityForecastUseCase.getByCityName(
        state.cityInput,
        event.lang,
      );
      emit(
        WeatherLoaded(
          cityInput: state.cityInput,
          city: data.city,
          currentWeather: data.weather,
          weatherForecast: data.forecast,
        ),
      );
    } catch (e) {
      emit(
        WeatherError(
          cityInput: state.cityInput,
        ),
      );
    }
  }
}
