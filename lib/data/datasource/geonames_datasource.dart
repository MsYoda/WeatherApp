import 'dart:convert';

import 'package:test_task/data/entities/city_entity.dart';
import 'package:http/http.dart' as http;
import 'package:test_task/data/entities/coordinates_entity.dart';
import 'package:test_task/domain/exceptions/api_exception.dart';
import 'package:test_task/domain/exceptions/app_exception.dart';

class GeonamesDatasource {
  static const _geonamesAPIUrl = 'https://secure.geonames.org/';
  static const _apiKey = 'Racesas';

  List<CityEntity> _citiesFromGeocode(List data) {
    return data
        .map(
          (e) => CityEntity(
            coordinates: CoordinatesEntity(
              lat: double.parse(e['lat']),
              lon: double.parse(e['lng']),
            ),
            name: e['name'],
            countryCode: e['countryCode'],
          ),
        )
        .toList()
        .cast();
  }

  Future<List<CityEntity>> findCitiesStartWith({
    required String cityName,
    required int limit,
    required String lang,
  }) async {
    final uri = Uri.parse(
      '$_geonamesAPIUrl/searchJSON?name_startsWith=$cityName&maxRows=$limit&username=$_apiKey&lang=$lang&featureClass=p&isNameRequired=true',
    );

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return _citiesFromGeocode(data['geonames']);
      } else {
        throw ApiException(statusCode: response.statusCode.toString());
      }
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }
}
