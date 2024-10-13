import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:test_task/core/localization/generated/locale_keys.g.dart';

abstract class DurationToLocaleKeyMapper {
  static String convertToLocalizedString(BuildContext context, Duration duration) {
    if (duration < const Duration(hours: 1)) {
      return context.plural(
        LocaleKeys.weather_lastUpdateTimeMinute,
        duration.inMinutes.toInt(),
      );
    }
    if (duration < const Duration(days: 1)) {
      return context.plural(
        LocaleKeys.weather_lastUpdateTimeHour,
        duration.inHours.toInt(),
      );
    }
    return context.plural(
      LocaleKeys.weather_lastUpdateTimeDay,
      duration.inDays.toInt(),
    );
  }
}
