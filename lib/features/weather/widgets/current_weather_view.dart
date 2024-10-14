import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:test_task/core/localization/generated/locale_keys.g.dart';

import 'package:test_task/core_ui/theme/app_dimens.dart';
import 'package:test_task/core_ui/theme/app_fonts.dart';
import 'package:test_task/core_ui/theme/app_images.dart';
import 'package:test_task/core_ui/utils/duration_to_string_mapper.dart';
import 'package:test_task/domain/models/cached_city.dart';
import 'package:test_task/domain/models/weather_info.dart';

class CurrentWeatherView extends StatelessWidget {
  final CachedCity city;
  final WeatherInfo weatherInfo;
  final VoidCallback onRefreshButtonPressed;

  const CurrentWeatherView({
    required this.weatherInfo,
    required this.city,
    required this.onRefreshButtonPressed,
    super.key,
  });

  Widget _buildAdditionalInfoColumn({
    required String name,
    required String value,
    required BuildContext context,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: AppFonts.openSans(
              fontSize: 22,
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
          Text(
            name,
            style: AppFonts.openSans(
              fontSize: 18,
              color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.6),
            ),
          ),
        ],
      );

  Widget _buildIconSection(
    BuildContext context,
  ) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppImages.weatherIcon(weatherInfo.conditionType),
                width: 200,
                height: 200,
                filterQuality: FilterQuality.high,
              ),
              const SizedBox(width: AppDimens.defaultSpace),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.translate(
                    offset: const Offset(-7, 0),
                    child: Text(
                      '${weatherInfo.temperature}°',
                      style: AppFonts.openSans(
                        fontSize: 64,
                        height: 1.1,
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                  ),
                  Text(
                    weatherInfo.conditionDescription,
                    style: AppFonts.openSans(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.75),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DurationToLocaleKeyMapper.convertToLocalizedString(
                  context,
                  DateTime.now().difference(city.timestamp),
                ),
                style: AppFonts.openSans(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
              ),
              const SizedBox(width: AppDimens.smallSpace),
              IconButton(
                onPressed: onRefreshButtonPressed,
                icon: Icon(
                  Icons.refresh,
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
              )
            ],
          ),
        ],
      );

  Widget _buildHeader(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${city.name}, ${city.countryCode}',
            textAlign: TextAlign.start,
            style: AppFonts.openSans(
              fontSize: 30,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
          Text(
            DateFormat('EEEE d MMMM', context.locale.toString()).format(weatherInfo.dateTime),
            textAlign: TextAlign.start,
            style: AppFonts.openSans(
              fontSize: 16,
              color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.75),
            ),
          ),
        ],
      );
  Widget _buildDataSection(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAdditionalInfoColumn(
                name: context.tr(LocaleKeys.weather_high),
                value: '${weatherInfo.maxTemperature}°',
                context: context,
              ),
              const SizedBox(height: AppDimens.defaultSpace),
              _buildAdditionalInfoColumn(
                name: context.tr(LocaleKeys.weather_low),
                value: '${weatherInfo.minTemperature}°',
                context: context,
              ),
            ],
          ),
          const SizedBox(width: AppDimens.largeSpace2x),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAdditionalInfoColumn(
                name: context.tr(LocaleKeys.weather_humidity),
                value: '${weatherInfo.humidity}%',
                context: context,
              ),
              const SizedBox(height: AppDimens.defaultSpace),
              _buildAdditionalInfoColumn(
                name: context.tr(LocaleKeys.weather_wind),
                value: context
                    .plural(
                      LocaleKeys.weather_kph,
                      weatherInfo.windSpeed,
                    )
                    .replaceAll(' ', ''),
                context: context,
              ),
            ],
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 700) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildHeader(context),
                  ),
                  const Spacer(),
                ],
              ),
              Container(
                height: 240,
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.smallSpace),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildIconSection(context),
                    ),
                    VerticalDivider(
                      width: 0,
                      thickness: 2,
                      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
                    ),
                    Expanded(
                      child: _buildDataSection(context),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              _buildHeader(context),
              _buildIconSection(context),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.bigSpace),
                child: Divider(
                  thickness: 2,
                  color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
                ),
              ),
              const SizedBox(height: AppDimens.smallSpace),
              _buildDataSection(context),
            ],
          );
        }
      },
    );
  }
}
