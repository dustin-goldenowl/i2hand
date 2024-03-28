import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/src/config/enum/attribute_enum.dart';
import 'package:i2hand/src/config/enum/options.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class AppConstantData {
  static const int passwordLength = 8;
  static const int userIdGenerateRandom = 20;
  static const int orderNumberLength = 10;

  static const String adminUsername = 'photostartup2020@gmail.com';
  static const String adminEmail = 'lance.dinh.goldenowl@gmail.com';

  static const double minPrice = 0.0;
  static const double maxPrice = 1000.0;

  static const SfRangeValues defaultPriceRange =
      SfRangeValues(minPrice, maxPrice);

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

  static List<Widget> listNotificationBanner = [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Assets.images.discountBanner.image(),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Assets.images.discountBanner2.image(),
    ),
  ];

  static List<TabItem> listDefaultAdminBottomBarItems = [
    TabItem<Widget>(
      icon: Assets.svg.category.svg(
          fit: BoxFit.contain,
          width: AppSize.s24,
          colorFilter:
              const ColorFilter.mode(AppColors.black, BlendMode.srcIn)),
    ),
    TabItem<Widget>(
      icon: Assets.svg.verified.svg(
        fit: BoxFit.contain,
        width: AppSize.s24,
        colorFilter: const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
      ),
    ),
    TabItem<Widget>(
      icon: Assets.svg.account.svg(
          fit: BoxFit.contain,
          width: AppSize.s24,
          colorFilter:
              const ColorFilter.mode(AppColors.black, BlendMode.srcIn)),
    ),
  ];

  static List<TabItem> listSelectedAdminBottomBarItems = [
    TabItem<Widget>(
      icon:
          Assets.jsons.category.lottie(fit: BoxFit.contain, width: AppSize.s30),
    ),
    TabItem<Widget>(
      icon:
          Assets.jsons.verified.lottie(fit: BoxFit.contain, width: AppSize.s44),
    ),
    TabItem<Widget>(
      icon:
          Assets.jsons.account.lottie(fit: BoxFit.contain, width: AppSize.s30),
    ),
  ];

  static List<OptionsEnum> categorysOptions = [
    OptionsEnum.edit,
    OptionsEnum.remove,
  ];

  static List<DropdownMenuItem<AttributeEnum>> getAllDropdownAttributes(
      BuildContext context) {
    return AttributeEnum.values
        .map((e) => DropdownMenuItem<AttributeEnum>(
              value: e,
              child: Text(
                e.getAttributeText(context),
                style: AppTextStyle.contentTexStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ))
        .toList();
  }
}
