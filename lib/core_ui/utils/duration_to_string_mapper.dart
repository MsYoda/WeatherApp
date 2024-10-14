import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:test_task/core/localization/generated/locale_keys.g.dart';

abstract class DurationToLocaleKeyMapper {
  static String convertToLocalizedString(BuildContext context, Duration duration) {
    if (duration < const Duration(hours: 1)) {
      final localeKey = duration.inMinutes.toInt() == 0
          ? LocaleKeys.weather_lastUpdateTimeMinuteZero
          : LocaleKeys.weather_lastUpdateTimeMinute;
      return context.plural(
        localeKey,
        duration.inMinutes.toInt(),
      );
    }
    if (duration < const Duration(days: 1)) {
      final localeKey = duration.inHours.toInt() == 0
          ? LocaleKeys.weather_lastUpdateTimeHourZero
          : LocaleKeys.weather_lastUpdateTimeHour;
      return context.plural(
        localeKey,
        duration.inHours.toInt(),
      );
    }
    final localeKey = duration.inDays.toInt() == 0
        ? LocaleKeys.weather_lastUpdateTimeDayZero
        : LocaleKeys.weather_lastUpdateTimeDay;
    return context.plural(
      localeKey,
      duration.inDays.toInt(),
    );
  }
}
