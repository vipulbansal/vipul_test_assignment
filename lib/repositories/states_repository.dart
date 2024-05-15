import 'dart:convert';

import 'package:vipul_test_assignment/commons/constants/constants.dart';
import 'package:vipul_test_assignment/data/models/country_model.dart';
import 'package:vipul_test_assignment/data/models/state_model.dart';

import '../data/network/http_provider.dart';

class StatesRepository {
  final HttpProvider _httpProvider = HttpProvider();

  Future<List<StateModel>> getStatesForSelectedCountry(String url) async {
    final dynamic response = await _httpProvider.get(
      url,
      headers: <String, String>{
        'content-type': 'application/json',
        'x-api-key': Constants.apiKey,
        'User-Agent': 'com.stagingcupid.api/10.16.6 (Release) Android/31',
      },
    );
    return stateModelFromJson(jsonEncode(response));
  }
}
