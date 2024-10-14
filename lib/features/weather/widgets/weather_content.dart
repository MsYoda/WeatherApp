import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/core/localization/generated/locale_keys.g.dart';
import 'package:test_task/core_ui/theme/app_dimens.dart';
import 'package:test_task/core_ui/theme/app_fonts.dart';
import 'package:test_task/core_ui/utils/debouncer.dart';
import 'package:test_task/features/weather/bloc/weather_bloc.dart';
import 'package:test_task/features/weather/bloc/weather_event.dart';
import 'package:test_task/features/weather/bloc/weather_state.dart';
import 'package:test_task/features/weather/screen/city_autocomplete.dart';
import 'package:test_task/features/weather/widgets/current_weather_view.dart';
import 'package:test_task/features/weather/widgets/weather_by_time_card.dart';

class WeatherContent extends StatefulWidget {
  const WeatherContent({
    super.key,
  });

  @override
  State<WeatherContent> createState() => _WeatherContentState();
}

class _WeatherContentState extends State<WeatherContent> {
  late final Debouncer _debouncer;

  Timer? _lastUpdateTimeUpdater;

  @override
  void initState() {
    super.initState();
    _debouncer = Debouncer();
    _lastUpdateTimeUpdater = Timer.periodic(const Duration(seconds: 60), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _lastUpdateTimeUpdater?.cancel();
    _debouncer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final bloc = context.read<WeatherBloc>();
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
                    context.tr(LocaleKeys.weather_appName),
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
                child: CityAutocomplete(
                  debouncer: _debouncer,
                ),
              ),
              if (state is WeatherLoaded) ...[
                const SizedBox(height: AppDimens.largeSpace2x),
                CurrentWeatherView(
                  city: state.city,
                  weatherInfo: state.currentWeather,
                  onRefreshButtonPressed: () => bloc.add(
                    WeatherRefresh(
                      lang: context.locale.languageCode,
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppDimens.largeSpace2x,
                ),
                Text(
                  context.tr(LocaleKeys.weather_weatherForecast),
                  style: AppFonts.openSans(
                    fontSize: 18,
                    color: colors.primaryContainer.withOpacity(1),
                  ),
                ),
                const SizedBox(height: AppDimens.smallSpace),
                CarouselSlider(
                  items: [
                    for (int i = 0; i < state.weatherForecast.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: WeatherByTimeCard(
                          weatherInfo: state.weatherForecast[i],
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
              ] else if (state is WeatherLoading)
                Padding(
                  padding: const EdgeInsets.only(top: 250),
                  child: CircularProgressIndicator(
                    color: colors.primaryContainer,
                  ),
                )
              else if (state is WeatherError) ...[
                const SizedBox(height: AppDimens.largeSpace2x),
                Text(
                  context.tr(LocaleKeys.weather_errorTitle),
                  textAlign: TextAlign.start,
                  style: AppFonts.openSans(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
                Text(
                  context.tr(LocaleKeys.weather_errorDescription),
                  textAlign: TextAlign.start,
                  style: AppFonts.openSans(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.75),
                  ),
                ),
              ]
            ],
          ),
        );
      },
    );
  }
}
