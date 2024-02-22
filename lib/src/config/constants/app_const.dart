import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/value.dart';

class AppConstantData {
  static const int passwordLength = 8;
  static const int userIdGenerateRandom = 20;

  static List<TabItem> listDefaultBottomBarItems = [
    TabItem<Widget>(
      icon: Assets.svg.home.svg(
          fit: BoxFit.contain,
          width: AppSize.s24,
          colorFilter:
              const ColorFilter.mode(AppColors.black, BlendMode.srcIn)),
    ),
    TabItem<Widget>(
      icon: Assets.svg.product.svg(
        fit: BoxFit.contain,
        width: AppSize.s24,
        colorFilter: const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
      ),
    ),
    TabItem<Widget>(
      icon: Assets.svg.post.svg(
        fit: BoxFit.contain,
        width: AppSize.s24,
        colorFilter: const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
      ),
    ),
    TabItem<Widget>(
      icon: Assets.svg.cart.svg(
          fit: BoxFit.contain,
          width: AppSize.s24,
          colorFilter:
              const ColorFilter.mode(AppColors.black, BlendMode.srcIn)),
    ),
    TabItem<Widget>(
      icon: Assets.svg.account.svg(
          fit: BoxFit.contain,
          width: AppSize.s24,
          colorFilter:
              const ColorFilter.mode(AppColors.black, BlendMode.srcIn)),
    ),
  ];

  static List<TabItem> listSelectedBottomBarItems = [
    TabItem<Widget>(
      icon: Assets.jsons.home.lottie(fit: BoxFit.contain, width: AppSize.s30),
    ),
    TabItem<Widget>(
      icon:
          Assets.jsons.product.lottie(fit: BoxFit.contain, width: AppSize.s44),
    ),
    TabItem<Widget>(
      icon: Assets.jsons.post.lottie(fit: BoxFit.contain, width: AppSize.s36),
    ),
    TabItem<Widget>(
      icon: SizedBox(
        height: AppSize.s24,
        width: AppSize.s24,
        child: OverflowBox(
          minHeight: AppSize.s90,
          maxHeight: AppSize.s90,
          minWidth: AppSize.s90,
          maxWidth: AppSize.s90,
          child: Assets.jsons.cart.lottie(fit: BoxFit.contain),
        ),
      ),
    ),
    TabItem<Widget>(
      icon:
          Assets.jsons.account.lottie(fit: BoxFit.contain, width: AppSize.s30),
    ),
  ];
}
