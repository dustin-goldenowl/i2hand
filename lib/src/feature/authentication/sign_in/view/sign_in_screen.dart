import 'package:flutter/material.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/widget/button/fill_button.dart';
import 'package:i2hand/widget/text_field/text_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DismissKeyBoard(
        child: Stack(
          children: [
            _renderBackground(),
            _renderSignInBody(context),
          ],
        ),
      ),
    );
  }

  Widget _renderBackground() {
    return Assets.svg.bubbles1.svg(fit: BoxFit.cover);
  }

  Widget _renderSignInBody(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _renderLoginText(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p5),
          _renderSubTitle(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p15),
          _renderEmailField(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p20),
          _renderNextButton(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p5),
          _renderCancelButton(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p45),
        ],
      ),
    );
  }

  Widget _renderLoginText(BuildContext context) {
    return Text(
      S.of(context).login,
      style: AppTextStyle.titleTextStyle.copyWith(fontSize: AppFontSize.f52),
    );
  }

  Widget _renderSubTitle(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          S.of(context).goodToSeeYouBack,
          style: AppTextStyle.contentTexStyle
              .copyWith(fontSize: AppFontSize.f18, color: AppColors.text),
        ),
        XPaddingUtils.horizontalPadding(width: AppPadding.p5),
        const Icon(
          Icons.favorite,
          color: AppColors.text,
          size: AppFontSize.f18,
        )
      ],
    );
  }

  Widget _renderEmailField(BuildContext context) {
    return XTextField(
        hintText: S.of(context).email,
        onChanged: (email) {
          // TODO: onChangedMail;
        });
  }

  Widget _renderNextButton(BuildContext context) {
    return XFillButton(
        onPressed: () => AppCoordinator.showSignInPassScreen(),
        label: Text(
          S.of(context).next,
          style: AppTextStyle.buttonTextStylePrimary,
        ));
  }

  Widget _renderCancelButton(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () {
              AppCoordinator.pop();
            },
            child: Text(
              S.of(context).cancel,
              style: AppTextStyle.textButtonTextStyle,
            )),
      ],
    );
  }
}
