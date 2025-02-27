import 'package:go_router/go_router.dart';
import 'package:test_task/features/weather/screen/weather_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WeatherScreen(),
    ),
  ],
);
