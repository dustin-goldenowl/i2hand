import 'package:flutter/material.dart';
import 'package:i2hand/src/theme/value.dart';

class XPaddingUtils {
  static Widget horizontalPadding({double width = AppPadding.p0}) =>
      SizedBox(width: width);

  static Widget verticalPadding({double height = AppPadding.p0}) =>
      SizedBox(height: height);
}
