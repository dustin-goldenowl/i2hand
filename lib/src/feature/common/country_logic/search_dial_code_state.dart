import 'package:i2hand/src/network/model/country/country_code.dart';

class SearchDialCodeState {
  List<CountryCode>? countryCodes;

  SearchDialCodeState({
    this.countryCodes,
  });

  SearchDialCodeState copyWith({
    List<CountryCode>? countryCodes,
  }) {
    return SearchDialCodeState(
      countryCodes: countryCodes ?? this.countryCodes,
    );
  }
}
