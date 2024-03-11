import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/model/country/country_code.dart';
import 'package:i2hand/src/network/model/country/location.dart';
import 'package:i2hand/src/service/link.dart';
import 'package:i2hand/src/utils/utils.dart';

class ApiUrls {
  final Uri countryPhoneCodeApi = Uri.parse(AppLink.urlGetCountryPhoneCode);
  final Uri countryApi = Uri.parse(AppLink.urlGetCountry);
}

class ApiServices {
  static Future<List<CountryCode>> fetchCountryDomain() {
    return http
        .get(ApiUrls().countryPhoneCodeApi)
        .then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if (statusCode != 200 || isNullOrEmpty(jsonBody)) {
        xLog.e(response.reasonPhrase);
        throw Exception(S.text.someThingWentWrong);
      }

      const JsonDecoder decoder = JsonDecoder();
      final useListContainer = decoder.convert(jsonBody);
      List<CountryCode> countryDomains = [];
      for (Map<String, dynamic> country in useListContainer) {
        Map<String, dynamic> idd = country['idd'];
        final root = idd['root'];
        final suffixes = idd['suffixes'] as List?;
        String suffixesText = '';
        if (!isNullOrEmpty(suffixes)) {
          suffixesText = suffixes![0];
        }
        countryDomains.add(CountryCode(
            name: country['name']['common'],
            flag: country['flags']['svg'],
            dial: '$root$suffixesText'));
      }
      return countryDomains;
    });
  }

  static Future<List<MLocation>> fetchCountryData() async {
    final headers = {
      'X-CSCAPI-KEY': 'OFhVM0tTOERHandleEplSnRmODR5b2M1SkxXQWpEUm1nMjBXZVNHaA=='
    };
    return http
        .get(ApiUrls().countryApi, headers: headers)
        .then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if (statusCode != 200 || isNullOrEmpty(jsonBody)) {
        xLog.e(response.reasonPhrase);
        throw Exception(S.text.someThingWentWrong);
      }

      const JsonDecoder decoder = JsonDecoder();
      final data = decoder.convert(jsonBody);
      List<MLocation> countryData = [];
      for (Map<String, dynamic> country in data) {
        countryData.add(MLocation.fromJson(country));
      }
      return countryData;
    });
  }

  static Future<List<MLocation>> fetchStateData(String ciso2) async {
    final headers = {
      'X-CSCAPI-KEY': 'OFhVM0tTOERHandleEplSnRmODR5b2M1SkxXQWpEUm1nMjBXZVNHaA=='
    };
    return http
        .get(Uri.parse('https://api.countrystatecity.in/v1/countries/$ciso2/states'), headers: headers)
        .then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if (statusCode != 200 || isNullOrEmpty(jsonBody)) {
        xLog.e(response.reasonPhrase);
        throw Exception(S.text.someThingWentWrong);
      }

      const JsonDecoder decoder = JsonDecoder();
      final data = decoder.convert(jsonBody);
      List<MLocation> stateData = [];
      for (Map<String, dynamic> state in data) {
        stateData.add(MLocation.fromJson(state));
      }
      return stateData;
    });
  }
}
