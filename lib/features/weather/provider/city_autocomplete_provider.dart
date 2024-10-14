import 'dart:async';

import 'package:test_task/domain/models/city.dart';
import 'package:test_task/domain/use_cases/city_search_usecase.dart';

class CityAutocompleteProvider {
  final CitySearchUsecase _citySearchUsecase;

  CityAutocompleteProvider({
    required CitySearchUsecase citySearchUsecase,
  }) : _citySearchUsecase = citySearchUsecase;

  Future<List<City>> getCitiesByInput({
    required String input,
    required String lang,
  }) async {
    return _citySearchUsecase.search(
      input: input,
      lang: lang,
    );
  }
}
