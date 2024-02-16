import 'package:flutter/material.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';

class FirstPageOnBoardingScreen extends StatelessWidget {
  const FirstPageOnBoardingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _renderImage(),
          _renderTitle(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p20),
          _renderContent(context),
        ],
      ),
    );
  }

  Widget _renderImage() {
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p59),
      child: Assets.images.shoppingCart3d.image(),
    );
  }

  Widget _renderTitle(BuildContext context) {
    return Text(
      S.of(context).createYourBuying,
      style: AppTextStyle.titleTextStyle.copyWith(color: AppColors.white),
      textAlign: TextAlign.center,
    );
  }

  Widget _renderContent(BuildContext context) {
    return Text(
      S.of(context).ourNewServiceMakesItEasy,
      style: AppTextStyle.contentTexStyle.copyWith(color: AppColors.white3),
      textAlign: TextAlign.center,
    );
  }
}
