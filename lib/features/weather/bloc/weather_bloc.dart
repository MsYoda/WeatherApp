import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/features/weather/bloc/weather_event.dart';
import 'package:test_task/features/weather/bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial());
}
