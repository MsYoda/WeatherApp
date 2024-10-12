import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_task/core_ui/theme/app_dimens.dart';
import 'package:test_task/core_ui/theme/app_fonts.dart';
import 'package:test_task/core_ui/theme/app_images.dart';
import 'package:test_task/domain/models/weather_info.dart';

class WeatherByTimeCard extends StatelessWidget {
  const WeatherByTimeCard({
    super.key,
    required this.weatherInfo,
  });

  final WeatherInfo weatherInfo;

  Widget _buildDataRow({
    required String name,
    required String value,
  }) =>
      Row(
        children: [
          Text(
            name,
            style: AppFonts.openSans(
              fontSize: 18,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: AppFonts.openSans(
              fontSize: 18,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: 500,
      height: 300,
      decoration: BoxDecoration(
        color: colors.secondaryContainer.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppDimens.defaultBorderRadius),
      ),
      padding: const EdgeInsets.all(
        AppDimens.defaultSpace,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRect(
                child: Align(
                  alignment: Alignment.center,
                  heightFactor: 0.6,
                  widthFactor: 0.6,
                  child: Image.asset(
                    AppImages.weatherIcon(weatherInfo.conditionType),
                    width: 150,
                    height: 150,
                  ),
                ),
              ),
              const SizedBox(width: AppDimens.defaultSpace),
              Text(
                '${weatherInfo.temperature}°',
                style: AppFonts.openSans(
                  fontSize: 56,
                  height: 1.1,
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.largeSpace),
          _buildDataRow(
            name: 'Time',
            value: DateFormat('hh:00').format(weatherInfo.dateTime),
          ),
          const SizedBox(height: AppDimens.smallSpace),
          _buildDataRow(
            name: 'Weather',
            value: 'Cloudy',
          ),
          const SizedBox(height: AppDimens.smallSpace),
          _buildDataRow(
            name: 'Humidity',
            value: '20%',
          ),
          const SizedBox(height: AppDimens.smallSpace),
          _buildDataRow(
            name: 'Wind',
            value: '8mph',
          )
        ],
      ),
    );
  }
}
