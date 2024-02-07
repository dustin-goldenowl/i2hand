import 'package:flutter/material.dart';
import 'package:i2hand/gen/fonts.gen.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/value.dart';

class AppTextStyle {
  static TextStyle labelStyle = const TextStyle(
      fontSize: AppFontSize.f14,
      fontFamily: FontFamily.raleway,
      color: AppColors.black);

  static TextStyle hintTextStyle = const TextStyle(
      fontSize: AppFontSize.f12,
      fontFamily: FontFamily.raleway,
      color: AppColors.grey4);

  static TextStyle buttonTextStylePrimary = const TextStyle(
      fontSize: AppFontSize.f16,
      color: AppColors.white,
      fontWeight: FontWeight.bold,
      fontFamily: FontFamily.raleway);

  static TextStyle titleTextStyle = const TextStyle(
      fontFamily: FontFamily.raleway,
      fontSize: AppFontSize.f24,
      fontWeight: FontWeight.bold);

  static TextStyle contentTexStyleBold = const TextStyle(
      fontFamily: FontFamily.nunitoSans,
      fontWeight: FontWeight.bold,
      color: AppColors.hintTextColor);

  static TextStyle contentTexStyle = const TextStyle(
    fontFamily: FontFamily.nunitoSans,
    color: AppColors.hintTextColor,
  );
}
