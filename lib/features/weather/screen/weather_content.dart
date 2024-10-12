import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/core_ui/theme/app_dimens.dart';
import 'package:test_task/core_ui/theme/app_fonts.dart';
import 'package:test_task/domain/models/weather_info.dart';
import 'package:test_task/features/weather/bloc/weather_bloc.dart';
import 'package:test_task/features/weather/bloc/weather_state.dart';
import 'package:test_task/features/weather/widgets/current_weather_view.dart';
import 'package:test_task/features/weather/widgets/weather_by_time_card.dart';

class WeatherContent extends StatelessWidget {
  const WeatherContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: AppDimens.smallSpace,
                    top: AppDimens.smallSpace,
                  ),
                  child: Text(
                    'WEATHER APP',
                    style: AppFonts.openSans(
                      fontSize: 20,
                      color: colors.primaryContainer,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 64),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.smallSpace),
                width: 600,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                    ),
                    hintText: 'Enter city name',
                    filled: true,
                    fillColor: colors.primaryContainer.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppDimens.defaultBorderRadius),
                      borderSide: BorderSide(
                        color: colors.secondaryContainer,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppDimens.largeSpace2x),
              CurrentWeatherView(
                weatherInfo: WeatherInfo(
                  temperature: 9,
                  maxTemperature: 15,
                  minTemperature: 8,
                  conditionType: '10d',
                  humidity: 10,
                  conditionDescription: 'Cloudy',
                  windSpeed: 7.8,
                  city: 'Minsk',
                  dateTime: DateTime(
                    2024,
                    10,
                    12,
                  ),
                ),
              ),
              const SizedBox(
                height: AppDimens.largeSpace2x,
              ),
              Text(
                'Todays weather',
                style: AppFonts.openSans(
                  fontSize: 18,
                  color: colors.primaryContainer.withOpacity(1),
                ),
              ),
              const SizedBox(height: AppDimens.smallSpace),
              CarouselSlider(
                items: [
                  for (int i = 9; i < 12; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: WeatherByTimeCard(
                        weatherInfo: WeatherInfo(
                          temperature: 9,
                          maxTemperature: 15,
                          minTemperature: 8,
                          conditionType: '10d',
                          humidity: 10,
                          conditionDescription: 'Cloudy',
                          windSpeed: 7.8,
                          city: 'Minsk',
                          dateTime: DateTime(
                            2024,
                            10,
                            12,
                            i,
                          ),
                        ),
                      ),
                    ),
                ],
                options: CarouselOptions(
                  height: 300,
                  enlargeFactor: 0.6,
                  viewportFraction: 0.25 * 1850 / MediaQuery.sizeOf(context).width,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  enableInfiniteScroll: false,
                ),
              ),
              const SizedBox(height: AppDimens.defaultSpace),
            ],
          ),
        );
      },
    );
  }
}
