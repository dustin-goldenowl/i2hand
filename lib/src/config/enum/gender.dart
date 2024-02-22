import 'package:flutter/material.dart';
import 'package:i2hand/src/localization/localization_utils.dart';

enum Gender {
  male,
  female;

  Gender getBabyGenderEnum(String type) {
    switch (type) {
      case 'Male':
        return Gender.male;
      case 'Female':
      default:
        return Gender.female;
    }
  }

  String getBabyGenderText(BuildContext context) {
    switch (this) {
      case Gender.male:
        return S.of(context).male;
      case Gender.female:
        return S.of(context).female;
    }
  }
}
