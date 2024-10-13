import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/di.dart';

import 'package:test_task/features/weather/bloc/weather_bloc.dart';
import 'package:test_task/features/weather/bloc/weather_event.dart';
import 'package:test_task/features/weather/screen/weather_content.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final lang = context.locale.languageCode;
    return BlocProvider(
      create: (context) => WeatherBloc(
        appLocator.get(),
      )..add(
          WeatherRefresh(
            lang: lang,
          ),
        ),
      child: Scaffold(
        body: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colors.surface,
                colors.surfaceTint,
              ],
            ),
          ),
          child: const WeatherContent(),
        ),
      ),
    );
  }
}
