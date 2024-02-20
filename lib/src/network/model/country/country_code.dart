import 'package:json_annotation/json_annotation.dart';

part 'country_code.g.dart';

@JsonSerializable(explicitToJson: true)
class CountryCode {
  final String? name;
  final String? dial;
  final String? flag;

  CountryCode({
    this.name,
    this.dial,
    this.flag,
  });

  factory CountryCode.fromJson(Map<String, dynamic> json) =>
      _$CountryCodeFromJson(json);

  Map<String, dynamic> toJson() => _$CountryCodeToJson(this);

  @override
  String toString() {
    return 'CountryCode(name: $name,  dial: $dial, flag: $flag)';
  }
}
