import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/model/country/country_code.dart';
import 'package:i2hand/src/utils/utils.dart';

class ApiUrls {
  final Uri countryApi = Uri.parse('https://restcountries.com/v3.1/all');
}

class ApiServices {
  static Future<List<CountryCode>> fetchCountryDomain() {
    return http.get(ApiUrls().countryApi).then((http.Response response) {
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
}
