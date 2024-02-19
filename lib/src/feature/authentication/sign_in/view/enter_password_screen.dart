import 'package:flutter/material.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/widget/avatar/avatar.dart';
import 'package:i2hand/widget/button/text_and_icon_button.dart';
import 'package:i2hand/widget/text_field/password_field.dart';

class EnterPasswordScreen extends StatelessWidget {
  const EnterPasswordScreen({super.key});

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
    return Assets.svg.bubbles2.svg(fit: BoxFit.cover);
  }

  Widget _renderSignInBody(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          XPaddingUtils.verticalPadding(height: AppPadding.p135),
          _renderAvatar(),
          XPaddingUtils.verticalPadding(height: AppPadding.p23),
          _renderHelloText(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p23),
          _renderSubTitle(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p10),
          _renderPasswordField(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p20),
          _renderForgotButton(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p5),
          _renderNotYouButton(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p45),
        ],
      ),
    );
  }

  Widget _renderHelloText(BuildContext context) {
    return Text(
      S.of(context).hello,
      style: AppTextStyle.titleTextStyle.copyWith(fontSize: AppFontSize.f28),
    );
  }

  Widget _renderSubTitle(BuildContext context) {
    return Text(
      S.of(context).typeYourPassword,
      style: AppTextStyle.contentTexStyle
          .copyWith(fontSize: AppFontSize.f18, color: AppColors.black),
    );
  }

  Widget _renderPasswordField(BuildContext context) {
    return const XPasswordField(passwordLength: 6);
  }

  Widget _renderForgotButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          //TODO: ForgotPassword logic
        },
        child: Text(
          S.of(context).forGotYourPassword,
          style: AppTextStyle.textButtonTextStyle
              .copyWith(fontSize: AppFontSize.f14),
        ));
  }

  Widget _renderNotYouButton(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          XTextAndIconButton(
            label: S.of(context).notYou,
            onPressed: () => AppCoordinator.pop(),
          ),
        ],
      ),
    );
  }

  Widget _renderAvatar() {
    return const XAvatar(
      imageSize: AppSize.s105,
    );
  }
}
