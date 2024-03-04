import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/model/country/country_code.dart';
import 'package:i2hand/src/network/model/country/location.dart';
import 'package:i2hand/src/service/link.dart';
import 'package:i2hand/src/utils/utils.dart';

class ApiUrls {
  final Uri countryPhoneCodeApi = Uri.parse(AppLink.urlGetCountryPhoneCode);
  final Uri getToken = Uri.parse(AppLink.urlGetToken);
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

  static Future<String> _getAccessToken() async {
    final headers = {
      "Accept": "application/json",
      "api-token":
          "dY0ftewbfn6EavlhOz2Flzd9OsfuhpocMBgDdJ7Hqfdqro73m-EouE_AmXd6bEyTBGA",
      "user-email": "lance.dinh.goldenowl@gmail.com"
    };
    return http
        .get(ApiUrls().getToken, headers: headers)
        .then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if (statusCode != 200 || isNullOrEmpty(jsonBody)) {
        xLog.e(response.reasonPhrase);
        throw Exception(S.text.someThingWentWrong);
      }

      const JsonDecoder decoder = JsonDecoder();
      final accessToken = decoder.convert(jsonBody);
      return accessToken['auth_token'];
    });
  }

  static Future<List<MLocation>> fetchCountryData() async {
    final accessToken = await _getAccessToken();
    final headers = {
      "Authorization": "Bearer $accessToken",
      "Accept": "application/json"
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
        countryData.add(MLocation(name: country['country_name']));
      }
      return countryData;
    });
  }

  static Future<List<MLocation>> fetchStateData(String country) async {
    final accessToken = await _getAccessToken();
    final headers = {
      "Authorization": "Bearer $accessToken",
      "Accept": "application/json"
    };
    return http
        .get(Uri.parse('${AppLink.urlGetState}$country'), headers: headers)
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
        stateData.add(MLocation(name: state['state_name']));
      }
      return stateData;
    });
  }

  static Future<List<MLocation>> fetchCityData(String state) async {
    final accessToken = await _getAccessToken();
    final headers = {
      "Authorization": "Bearer $accessToken",
      "Accept": "application/json"
    };
    return http
        .get(Uri.parse('${AppLink.urlGetCity}$state'), headers: headers)
        .then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if (statusCode != 200 || isNullOrEmpty(jsonBody)) {
        xLog.e(response.reasonPhrase);
        throw Exception(S.text.someThingWentWrong);
      }

      const JsonDecoder decoder = JsonDecoder();
      final data = decoder.convert(jsonBody);
      List<MLocation> cityData = [];
      for (Map<String, dynamic> city in data) {
        cityData.add(MLocation(name: city['city_name']));
      }
      xLog.e(cityData);
      return cityData;
    });
  }
}
