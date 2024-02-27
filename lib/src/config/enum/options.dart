import 'package:flutter/material.dart';
import 'package:i2hand/src/localization/localization_utils.dart';

enum OptionsEnum {
  // Category's options
  edit,
  remove;

  String getOptionsText(BuildContext context) {
    switch (this) {
      case OptionsEnum.edit:
        return S.of(context).edit;
      case OptionsEnum.remove:
        return S.of(context).remove;
      default:
        return '';
    }
  }
}
