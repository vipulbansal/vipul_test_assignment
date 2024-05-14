import 'dart:convert';


import 'package:vipul_test_assignment/commons/constants/constants.dart';
import 'package:vipul_test_assignment/data/models/country_model.dart';

import '../data/network/http_provider.dart';

class CountriesRepository {
  final HttpProvider _httpProvider = HttpProvider();

  Future<List<CountryModel>> getAllCountries() async {
    final dynamic response = await _httpProvider.get(
      Constants.countries,
      headers: <String, String>{
        'content-type': 'application/json',
      },
    );

    return countryModelFromJson(response.data);
  }
}
