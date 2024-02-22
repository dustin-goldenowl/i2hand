import 'package:flutter/material.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/utils/string_utils.dart';

class AppValidator {
  static final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  static String? emailValidated(String? value, BuildContext context) {
    if (StringUtils.isNullOrEmpty(value)) {
      return S.of(context).thisFieldIsNotEmpty;
    }
    return emailRegExp.hasMatch(value ?? '')
        ? null
        : S.of(context).emailInvalid;
  }

  static String? emptyFieldValidated(String? value, BuildContext context) {
    if (StringUtils.isNullOrEmpty(value)) {
      return S.of(context).thisFieldIsNotEmpty;
    }
    return null;
  }

  static String? passwordCreateValidated(String? value, BuildContext context) {
    if (StringUtils.isNullOrEmpty(value)) {
      return S.of(context).thisFieldIsNotEmpty;
    } else if (value!.length < 6) {
      return S.of(context).passwordMustBeSixOrMore;
    } else {
      return null;
    }
  }
}
