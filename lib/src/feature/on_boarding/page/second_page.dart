import 'package:flutter/material.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/src/feature/on_boarding/page/item/i2hand_text.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/widget/button/fill_button.dart';

class SecondPageOnBoardingScreen extends StatelessWidget {
  const SecondPageOnBoardingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          XPaddingUtils.verticalPadding(height: AppPadding.p20),
          _renderAppName(),
          _renderImage(),
          _renderContent(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p20),
          _renderLetsStartButton(context),
        ],
      ),
    );
  }

  Widget _renderImage() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: AppPadding.p45, bottom: AppPadding.p23),
          child: Assets.images.devices.image(),
        ),
        Positioned(
          top: 0,
          child: Assets.images.thunderSale.image(),
        ),
      ],
    );
  }

  Widget _renderContent(BuildContext context) {
    return Text(
      S.of(context).discoverProductsThatSuitYourNeeds,
      style: AppTextStyle.contentTexStyleBold.copyWith(color: AppColors.white),
    );
  }

  Widget _renderAppName() {
    return const XAppName(color: AppColors.yellow);
  }

  Widget _renderLetsStartButton(BuildContext context) {
    return XFillButton(
      bgColor: AppColors.white,
      borderRadius: AppRadius.r30,
      onPressed: () => AppCoordinator.showStartScreen(),
      label: Text(
        S.of(context).letsGetStarted,
        style: AppTextStyle.buttonTextStylePrimary
            .copyWith(color: AppColors.primary),
      ),
    );
  }
}
