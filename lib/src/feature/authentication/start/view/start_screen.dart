import 'package:flutter/material.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/src/feature/on_boarding/page/item/i2hand_text.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/decorations.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/widget/button/fill_button.dart';
import 'package:i2hand/widget/button/text_and_icon_button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey7,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
        child: Column(
          children: [
            _renderBody(context),
            _renderOptions(context),
            XPaddingUtils.verticalPadding(height: AppPadding.p45),
          ],
        ),
      ),
    );
  }

  Widget _renderBody(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _renderLogoIcon(),
        _renderAppName(),
        _renderDescription(context),
      ],
    ));
  }

  Widget _renderLogoIcon() {
    return Container(
      width: AppSize.s134,
      height: AppSize.s134,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s134 / 2),
        color: AppColors.white,
        boxShadow: AppDecorations.shadow,
      ),
      padding: const EdgeInsets.all(AppPadding.p5),
      child: Assets.images.logo.image(),
    );
  }

  Widget _renderAppName() {
    return const XAppName();
  }

  Widget _renderDescription(BuildContext context) {
    return Text(
      S.of(context).discoverProductsThatSuitYourNeeds,
      textAlign: TextAlign.center,
      style: AppTextStyle.contentTexStyle.copyWith(color: AppColors.text),
    );
  }

  Widget _renderOptions(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _renderSignUpButton(context),
        XPaddingUtils.verticalPadding(height: AppPadding.p15),
        _renderSignInButton(context),
      ],
    );
  }

  Widget _renderSignUpButton(BuildContext context) {
    return XFillButton(
        label: Text(
      S.of(context).createAccount,
      style: AppTextStyle.buttonTextStylePrimary,
    ));
  }

  Widget _renderSignInButton(BuildContext context) {
    return XTextAndIconButton(
      label: S.of(context).iAlreadyHaveAccount,
      onPressed: () => AppCoordinator.showSignInEmailScreen(),
    );
  }
}
