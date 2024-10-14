import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/core/localization/generated/locale_keys.g.dart';
import 'package:test_task/core_ui/theme/app_dimens.dart';
import 'package:test_task/core_ui/utils/debouncer.dart';
import 'package:test_task/features/weather/bloc/weather_bloc.dart';
import 'package:test_task/features/weather/bloc/weather_event.dart';
import 'package:test_task/features/weather/provider/city_autocomplete_provider.dart';

class CityAutocomplete extends StatelessWidget {
  final Debouncer debouncer;
  const CityAutocomplete({
    required this.debouncer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final bloc = context.read<WeatherBloc>();

    return Autocomplete<String>(
      optionsBuilder: (value) async {
        final result = await debouncer.debounce(
            duration: const Duration(milliseconds: 500),
            func: () async {
              if (value.text.isEmpty) return [];
              return context.read<CityAutocompleteProvider>().getCitiesByInput(
                    input: value.text,
                    lang: context.locale.languageCode,
                  );
            });

        return result.map((e) => '${e.name}, ${e.countryCode}');
      },
      optionsViewBuilder: (context, onSelected, options) {
        return LayoutBuilder(builder: (context, constraints) {
          return Transform.translate(
            offset: const Offset(1, 0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Material(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                ),
                child: SizedBox(
                  height: 52.0 * options.length,
                  width: constraints.maxWidth >= 565
                      ? 565
                      : constraints.maxWidth - AppDimens.defaultSpace * 2,
                  child: ListView.builder(
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String option = options.elementAt(index);
                      return InkWell(
                        onTap: () => onSelected(option),
                        child: Padding(
                          padding: const EdgeInsets.all(AppDimens.defaultSpace),
                          child: Text(option),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        });
      },
      onSelected: (option) {
        bloc.add(
          WeatherCityInputSubmitted(
            value: option,
            lang: context.locale.languageCode,
          ),
        );
      },
      fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          onSubmitted: (_) => onFieldSubmitted(),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.cancel_outlined,
              ),
              onPressed: () => textEditingController.clear(),
            ),
            prefixIcon: const Icon(
              Icons.search,
            ),
            hintText: context.tr(LocaleKeys.weather_cityInputHint),
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
        );
      },
    );
  }
}
